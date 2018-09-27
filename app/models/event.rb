class Event < ApplicationRecord
  validates :name, presence: true
  validates :venue, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :address, presence: true

  mount_uploaders :images, EventImageUploader

  attr_accessor :delete_assets
  after_validation do
    uploaders = images.delete_if do |uploader|
      if Array(delete_assets).include?(uploader.file.identifier)
        uploader.remove!
        true
      end
    end
    write_attribute(:images, uploaders.map { |uploader| uploader.file.identifier })
  end

  def event_images=(files)
    appended = files.map do |file|
      uploader = _mounter(:images).blank_uploader
      uploader.cache! file
      uploader
    end
    super(images + appended)
  end

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
