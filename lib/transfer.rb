class Transfer

  attr_reader :sender, :receiver, :status
  attr_accessor :amount

  def initialize(sender, receiver, amount)
    @status = 'pending'
    @amount = amount
    @sender = sender
    @receiver = receiver
  end

  def valid?
    if sender.valid? && receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction
    if sender.valid? && sender.balance > @amount && @status != 'complete'
      receiver.deposit(@amount)
      sender.balance -= @amount
      @status = 'complete'
    else
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == 'complete'
      sender.deposit(@amount)
      receiver.balance -= @amount
      @status = "reversed"

    end

  end

end
