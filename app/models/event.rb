class Event < ApplicationRecord
validates :name, presence: true
validates :venue, presence: true
validates :start_time, presence: true
validates :end_time, presence: true
validates :address, presence: true

def paypal_url(event)
  values = {
  :business => "daniel.amah@gmail.com", #test email
  :cmd => '_cart',
  :upload => 1,
  :return => "http://localhost:3000"
  }

  values.merge!({
  "amount_1" => event.ticket_price,
  "item_name_1" => event.name,
  "item_number_1" => event.id,
  "quantity_1" => '1'
  })

  # This is a paypal sandbox url and should be changed for production.
  # Better define this url in the application configuration setting on environment
  # basis.
  "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
end

end
