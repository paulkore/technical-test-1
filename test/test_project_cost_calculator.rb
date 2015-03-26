require 'minitest/autorun'

require_relative '../lib/solution'

class TestProjectCostCalculator < Minitest::Test

  def setup
    @project_calc = ProjectCostCalculator.new
  end


  # Example scenario 1 from problem description
  def test_example_1
    result = @project_calc.calculate_project_cost(base_price: 1299.99, num_workers: 3, product_categories: ['food'])
    assert_equal 1591.58, result
  end

  # Example scenario 2 from problem description
  def test_example_2
    result = @project_calc.calculate_project_cost(base_price: 5432.00, num_workers: 1, product_categories: ['drugs'])
    assert_equal 6199.81, result
  end

  # Example scenario 3 from problem description
  def test_example_3
    result = @project_calc.calculate_project_cost(base_price: 12456.95, num_workers: 4, product_categories: ['books'])
    assert_equal 13707.63, result
  end

  # invalid input tests (base_price argument)
  def test_base_price_invalid_inputs
    assert_raises ArgumentError do
      @project_calc.calculate_project_cost(base_price: nil, num_workers: 3, product_categories: ['electronics', 'books'])
    end
    assert_raises ArgumentError do
      @project_calc.calculate_project_cost(base_price: -12456.95, num_workers: 3, product_categories: ['electronics', 'books'])
    end
    assert_raises ArgumentError do
      @project_calc.calculate_project_cost(base_price: 0.00, num_workers: 3, product_categories: ['electronics', 'books'])
    end
  end

  # invalid input tests (num_workers argument)
  def test_num_workers_invalid_inputs
    assert_raises ArgumentError do
      @project_calc.calculate_project_cost(base_price: 12456.95, num_workers: nil, product_categories: ['electronics', 'books'])
    end
    assert_raises ArgumentError do
      @project_calc.calculate_project_cost(base_price: 12456.95, num_workers: 0, product_categories: ['electronics', 'books'])
    end
    assert_raises ArgumentError do
      @project_calc.calculate_project_cost(base_price: 12456.95, num_workers: -8, product_categories: ['electronics', 'books'])
    end
  end

  # invalid input tests (product_categories argument)
  def test_product_categories_invalid_inputs
    assert_raises ArgumentError do
      @project_calc.calculate_project_cost(base_price: 12456.95, num_workers: 3, product_categories: nil)
    end
    assert_raises ArgumentError do
      @project_calc.calculate_project_cost(base_price: 12456.95, num_workers: 3, product_categories: 'electronics')
    end
  end


  def test_one_worker_no_product_markup
    actual = @project_calc.calculate_project_cost(base_price: 1000.00, num_workers: 1, product_categories: ['other'])
    expected = ((1000.00 * 1.05) * (1 + 0.012 * 1)).round(2)
    assert_equal(expected, actual)
  end

  def test_multiple_workers_no_product_markup
    actual = @project_calc.calculate_project_cost(base_price: 1000.00, num_workers: 5, product_categories: ['other'])
    expected = ((1000.00 * 1.05) * (1 + 0.012 * 5)).round(2)
    assert_equal(expected, actual)
  end

  def test_one_worker_unknown_product_category
    actual = @project_calc.calculate_project_cost(base_price: 1000.00, num_workers: 1, product_categories: ['widgets'])
    expected = ((1000.00 * 1.05) * (1 + 0.012 * 1)).round(2)
    assert_equal(expected, actual)
  end

  def test_one_worker_one_product_markup
    actual = @project_calc.calculate_project_cost(base_price: 1000.00, num_workers: 1, product_categories: ['electronics'])
    expected = ((1000.00 * 1.05) * (1 + 0.012 * 1 + 0.02)).round(2)
    assert_equal(expected, actual)
  end

  def test_multiple_workers_one_product_markup
    actual = @project_calc.calculate_project_cost(base_price: 1000.00, num_workers: 5, product_categories: ['electronics'])
    expected = ((1000.00 * 1.05) * (1 + 0.012 * 5 + 0.02)).round(2)
    assert_equal(expected, actual)
  end

  def test_one_worker_multiple_product_markups
    actual = @project_calc.calculate_project_cost(base_price: 1000.00, num_workers: 1, product_categories: ['electronics', 'food', 'drugs'])
    expected = ((1000.00 * 1.05) * (1 + 0.012 * 1 + 0.02 + 0.13 + 0.075)).round(2)
    assert_equal(expected, actual)
  end

  def test_multiple_workers_multiple_product_markups
    actual = @project_calc.calculate_project_cost(base_price: 1000.00, num_workers: 5, product_categories: ['electronics', 'food', 'drugs'])
    expected = ((1000.00 * 1.05) * (1 + 0.012 * 5 + 0.02 + 0.13 + 0.075)).round(2)
    assert_equal(expected, actual)
  end


end