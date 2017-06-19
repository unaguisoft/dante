class PropertyMailer < ApplicationMailer

  def question(property, question)
    @property = property
    @question = question
    send_email(property.user.email, 'Consulta sobre propiedad')
  end

  def contact(question)
    @question = question
    send_email('Consulta')
  end

  def valuation(question)
    @question = question
    send_email('Solicitud de Tasación')
  end

  private

  def send_email(recipient = ENV['EMAIL_CONTACT_TO'], subject)
    mail(to: recipient, subject: subject)
  end

end
