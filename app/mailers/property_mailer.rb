class PropertyMailer < ApplicationMailer

  def question(property, question)
    @property = property
    @question = question
    mail(to: property.user.email, subject: 'Consulta sobre propiedad')
  end

  def contact(question)
    @question = question
    mail(to: ENV['EMAIL_CONTACT_TO'], subject: 'Consulta')
  end

end
