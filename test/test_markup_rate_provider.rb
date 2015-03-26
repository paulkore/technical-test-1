require 'minitest/autorun'

require_relative '../lib/solution'

class TestMarkupRateProvider < Minitest::Test

  def setup
    @provider = MarkupRateProvider.new
  end

  def test_flat_rate
    assert_equal(0.05, @provider.project_flat_rate)
  end

  def test_worker_rate_invalid_inputs
    assert_raises ArgumentError do
      @provider.rate_for_workers(nil)
    end
    assert_raises ArgumentError do
      @provider.rate_for_workers(0)
    end
  end

  def test_worker_rate_one_worker_returns_worker_rate
    assert_equal(0.012, @provider.rate_for_workers(1))
  end

  def test_worker_rate_N_workers_returns_worker_rate_multiplied_by_N
    assert_equal(0.012 * 15, @provider.rate_for_workers(15))
  end



  def test_product_rate_invalid_input
    assert_raises ArgumentError do
      @provider.rate_for_category(nil)
    end
  end


  def test_product_rate_drugs_category_returns_expected_rate
    assert_equal(0.075, @provider.rate_for_category('drugs'))
  end

  def test_product_rate_food_category_returns_expected_rate
    assert_equal(0.13, @provider.rate_for_category('food'))
  end

  def test_product_rate_electronics_category_returns_expected_rate
    assert_equal(0.02, @provider.rate_for_category('electronics'))
  end

  def test_product_rate_other_category_returns_zero_rate
    assert_equal(0.00, @provider.rate_for_category('other'))
  end

  def test_product_rate_undefined_category_returns_zero_rate
    assert_equal(0.00, @provider.rate_for_category('widgets'))
  end



end