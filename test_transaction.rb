require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < Minitest::Test
  def setup
    @transaction = Transaction.new(30)
  end

  def test_prompt_for_payment
    input = StringIO.new('30\n')
    @transaction.prompt_for_payment(input: input)
    assert_equal 30, @transaction.amount_paid

    input2 = StringIO.new('20\n')
    assert_output('That is not the correct amount. Please make sure to pay the full cost.') do
      @transaction.prompt_for_payment(input: input2)
    end
  end
end


