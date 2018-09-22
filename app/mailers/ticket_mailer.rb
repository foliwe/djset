class TicketMailer < ApplicationMailer
  default from: "from@example.com"

  def email_ticket
    mail(to: "test@exmple.com", subject: 'Sample Email')
  end
end
