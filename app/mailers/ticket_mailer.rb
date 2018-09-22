class TicketMailer < ApplicationMailer
  default from: "djtakeawayint@gmail.com"

  def email_ticket
    attachments["ticket.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(pdf: 'ticket', template: 'home/ticket.html.erb')
    )
    mail(to: "aqdasmalik8@gmail.com", subject: 'Sample Email')
  end
end
