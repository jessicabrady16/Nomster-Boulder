class NotificationMailer < ApplicationMailer
  default from: "no-reply@nomsterapp.com"


  def comment_added
    mail(to: "jessicabrady16@gmail.com",
      subject: "Someone commented on your Nomster post!")
  end
end
