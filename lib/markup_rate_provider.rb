class MarkupRateProvider

  PROJECT_FLAT_RATE = 0.05

  RATE_PER_WORKER = 0.012

  PRODUCT_CATEGORY_RATES = {
      ProductCategory::DRUGS => 0.075,
      ProductCategory::FOOD => 0.13,
      ProductCategory::ELECTRONICS => 0.02,
      ProductCategory::OTHER => 0.00,
  }



  # @return - the flat markup rate to be applied to the base cost,
  # before all other markups are calculated
  def project_flat_rate
    PROJECT_FLAT_RATE
  end

  # @return - the markup rate to be applied to the project cost,
  # for the specified number of workers (positive integer)
  def rate_for_workers(num_workers)
    raise ArgumentError, "num_workers must be a positive integer" unless num_workers.kind_of?(Integer) && num_workers > 0
    (RATE_PER_WORKER * num_workers).round(5)
  end

  # @return - the markup rate to be applied to the project cost,
  # for the specified product category (string value)
  def rate_for_category(product_category)
    raise ArgumentError, "product_category must be a string" unless product_category.kind_of?(String)
    if PRODUCT_CATEGORY_RATES.key?(product_category)
      PRODUCT_CATEGORY_RATES[product_category]
    else
      PRODUCT_CATEGORY_RATES[ProductCategory::OTHER]
    end
  end

end