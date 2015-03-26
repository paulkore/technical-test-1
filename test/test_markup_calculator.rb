require 'minitest/autorun'

require_relative '../lib/solution'

class TestMarkupCalculator < Minitest::Test

  def setup
    @markup_calc = MarkupCalculator.new
  end

  def test_invalid_inputs_amount
    assert_raises ArgumentError do
      @markup_calc.markup_amount(nil, 0.05)
    end
    assert_raises ArgumentError do
      @markup_calc.markup_amount(0.00, 0.05)
    end
    assert_raises ArgumentError do
      @markup_calc.markup_amount(-150.00, 0.05)
    end
  end

  def test_invalid_inputs_markup_rate
    assert_raises ArgumentError do
      @markup_calc.markup_amount(25.50, nil)
    end
    assert_raises ArgumentError do
      @markup_calc.markup_amount(25.50, -0.05)
    end
  end

  def test_markup_rate_zero_should_return_zero
    assert_equal(0.00, @markup_calc.markup_amount(25.50, 0))
  end

  def test_markup_rate_non_zero_percentage_amount
    assert_equal(2.55, @markup_calc.markup_amount(25.50, 0.10))
  end

  def test_markup_amount_rounded_two_decimal_places
    assert_equal( 1.2750000000000001, 25.50 * 0.05)
    assert_equal(1.28, @markup_calc.markup_amount(25.50, 0.05))
  end

end