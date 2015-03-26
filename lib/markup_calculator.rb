class MarkupCalculator

  # This method calculates the markup on a specified amount, based on a percentage rate
  #
  # * *Args* :
  #   - +amount+ - the amount to calculate the markup for (positive value, non-zero)
  #   - +markup_rate+ - the applicable markup rate (percentage value, greater or equal to 0)
  #
  # * *Returns* :
  #   - the markup amount, which equals the amount times the markup rate, rounded to 2 decimal places
  #
  def markup_amount(amount, markup_rate)
    raise ArgumentError, "amount must be a positive numeric value" unless amount.kind_of?(Numeric) && amount > 0
    raise ArgumentError, "markup_rate must be a decimal value greater or equal to 0" unless markup_rate.kind_of?(Numeric) && markup_rate >= 0.00

    (amount * markup_rate).round(2)
  end

end