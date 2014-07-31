class InvitationMailer < ActionMailer::Base
  default from: "killerqueenchicago@gmail.com"

  def invitation_created(email, host)
    @email = email
    @host = host
    mail(to: @email, subject: "Join My Killer Queen Team")
  end
end
