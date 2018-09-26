# app/services/paypal_service.rb

class PaypalService
  def initialize(params)
    @return_url = params[:return_url]
    @cancel_url = params[:cancel_url]
    @money = params[:price]
    @currency = 'GBP'
  end

  def create_payment
    payment = PayPal::SDK::REST::Payment.new({
      intent: "sale",
      payer: { payment_method: "paypal" },
      redirect_urls: { return_url: @return_url, cancel_url: @cancel_url },
      transactions: [{ item_list: { items: [
          {name: 'Ticket', price: @money, currency: 'GBP', quantity: '1'}
        ] },
        amount: { total: @money,
        currency: @currency }
      }]
    })
    payment.create
    payment
  end

  def self.execute_payment(payment_id, payer_id)
    payment = PayPal::SDK::REST::Payment.find(payment_id)
    payment.execute(payer_id: payer_id) unless payment.error
    payment
  end

private
  # PayPal will also check all the currencies and subtotals
  # whether are match to the currency and total amount in payment object.
  # It's not a required field, but it's better to show all details
  # for your buyers when getting their approval.
end
