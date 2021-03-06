class EventsController < ApplicationController
  before_action :set_events_params, only: [:destroy, :edit, :update]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new
    if @event.save
      redirect_to root_path, notice:"the event  #{event.name} has been created"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def destroy_image
    @event = Event.find(params[:event_id].to_i)
    # @event.delete_image(params[:image_name])
    # remove_image_at_index(params[:image_id].to_i)
    if @event.save
        flash[:success] = "delete successfull"
        redirect_to('/admin/event/'+@event.id.to_s+'/edit')
    else
        flash.now[:danger] = "sorry can't delete the photo"
        render("show")
    end
  end

  def buy
    event = Event.find params[:event]
    @paypal_transaction_success_url = ENV['APP_URL']+'payment_successful?event='+event.id.to_s
    @Paypal_transaction_cancel_url = ENV['APP_URL']+'payment_successful?event='+event.id.to_s
    @selected_price = event.ticket_price
    if (@payment = new_paypal_service).error.nil?
      payment_no = @payment.id
      @redirect_url = @payment.links.find{|v| v.method == "REDIRECT" }.href

      redirect_to @redirect_url
    else
      @message = @payment.error
      render(
        html: ("<script>alert('"+@message.to_s+"')</script>").html_safe,
        layout: 'application'
      )
    end
  end

  def payment_successful
    payment_id = params.fetch(:paymentId, nil)
    if payment_id.present?
      @payment = execute_paypal_payment({
        token: payment_id, payment_id: payment_id,
        payer_id: params[:PayerID]})
    end

    if @payment && @payment.success?
      event = Event.find params[:event]
      event.sold_count += 1
      event.save
      TicketMailer.email_ticket(@payment.payer.payer_info.email, event).deliver
      message = 'Your ticket has been emailed to your paypal email address.'
    else
      message = 'There was some error processing your payment. Please try again.'
    end
    render(
      html: ("<script>
        alert('"+message+"');
        my_close()

        function my_close(){
          window.location = '#{ENV['APP_URL']}';
        }
        </script>
        ").html_safe,
      layout: 'application'
    )
  end

  private

  def set_events_params
    params.require(:event).permit(:name, :address, :start_time, :end_time, :venue)
  end

  def new_paypal_service
    PaypalService.new({
      return_url: @paypal_transaction_success_url,
      cancel_url: @Paypal_transaction_cancel_url,
      price: @selected_price
    }).create_payment
  end

  def execute_paypal_payment(params)
    PaypalService.execute_payment(params[:payment_id], params[:payer_id])
  end

  private

  def remove_image_at_index(index)
    remain_images = @event.images
    if index == 0 && @event.images.size == 1
        @event.remove_images!
    else
        deleted_image = remain_images.delete_at(index)
        deleted_image.try(:remove!)
        @event.images = remain_images
    end
  end

end
