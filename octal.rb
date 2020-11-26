class Octal
  attr_reader :octal

  def initialize(octal)
    @octal = octal
  end

  def valid_input?
    valid_digits = '01234567'
    octal.each_char { |char| return false unless valid_digits.include?(char) }
  end

  def to_decimal
    return 0 unless valid_input?
    reverse_octal = octal.reverse
    decimal = 0

    reverse_octal.each_char.with_index { |digit, exp| decimal += (digit.to_i * 8**exp) }
    decimal
  end
end
