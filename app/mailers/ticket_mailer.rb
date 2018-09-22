class TicketMailer < ApplicationMailer
  default from: "from@example.com"

  def email_ticket
    mail(to: "aqdasmalik8@gmail.com", subject: 'Sample Email')
  end
end
