class Event < ApplicationRecord
  validates :name, presence: true
  validates :venue, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :address, presence: true

  mount_uploaders :images, EventImageUploader
  mount_uploader  :ticket_image, EventImageUploader
  mount_uploader  :poster_image, EventImageUploader

  serialize :images, JSON

  # attr_accessor :remove_image

  # after_validation do
  #   uploaders = images.delete_if do |uploader|
  #     puts "======================== \n" * 15
  #     puts uploader.file.identifier
  #     if Array(delete_images).include?(uploader.file.identifier)
  #       uploader.remove!
  #       true
  #     end
  #   end
  #   write_attribute(:images, uploaders.map { |uploader| uploader.file.identifier })
  # end

  def delete_image(image_file)
    image_to_delete = self.images.select do |image| # find the image based on file name
      image.file.filename == image_file
    end
    if image_to_delete && image_to_delete[0] # delete the image that was found
      self.images = self.images - [image_to_delete[0]]
      if self.images.empty? && read_attribute(:images).size == 1 # update the internal attribute
        write_attribute(:images, [])
      end
      image_to_delete[0].remove! # delete from the file system # save the updated images attribute
    end
  end

  def images=(files)
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
