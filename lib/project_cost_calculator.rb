class ProjectCostCalculator

  def initialize
    # helper components
    @markup_rate_provider = MarkupRateProvider.new
    @markup_calculator = MarkupCalculator.new
  end


  # This method calculates the markup on a re-packaging job, and returns the final cost of the project
  #
  # * *Args* :
  #   - +base_price+ - the base price of the goods to be re-packaged
  #   - +num_workers+ - the number of workers required for the job
  #   - +product_categories+ -  an array of product categories applicable to the goods in the project:
  #                             * ['drugs', 'food', 'electronics', 'other'],
  #                             * all other values are categorized as 'other'.
  #                             * this array can be empty
  #
  # * *Returns* :
  #   - the base price, plus the applicable markup
  #
  def calculate_project_cost(base_price: nil, num_workers: nil, product_categories: nil)
    raise ArgumentError, "base_price must be a positive numeric value" unless base_price.kind_of?(Numeric) && base_price > 0
    raise ArgumentError, "num_workers must be a positive integer" unless num_workers.kind_of?(Integer) && num_workers > 0
    raise ArgumentError, "product_categories must be an array" unless product_categories.kind_of?(Array)

    project_flat_rate = @markup_rate_provider.project_flat_rate
    price_with_initial_markup = base_price + @markup_calculator.markup_amount(base_price, project_flat_rate)

    worker_rate = @markup_rate_provider.rate_for_workers(num_workers)
    worker_markup = @markup_calculator.markup_amount(price_with_initial_markup, worker_rate)

    product_markup = 0.00
    if product_categories
      product_categories.each do |product_category|
        rate_for_category = @markup_rate_provider.rate_for_category(product_category)
        markup_for_category = @markup_calculator.markup_amount(price_with_initial_markup, rate_for_category)
        product_markup += markup_for_category
      end
    end

    # total project cost
    (price_with_initial_markup + worker_markup + product_markup).round(2)
  end




end