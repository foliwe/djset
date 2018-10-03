class TicketMailer < ApplicationMailer
  default from: "djtakeawayint@gmail.com"

  def email_ticket(email, event)
    @event = event
    puts '== ' * 500
    puts @event.ticket_image.url
    attachments["ticket.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: 'ticket', template: 'home/ticket.html.erb')
    )
    mail(to: email, subject: 'Sample Email')
  end
end
