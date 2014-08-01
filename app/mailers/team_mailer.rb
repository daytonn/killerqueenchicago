class TeamMailer < ActionMailer::Base
  default from: "killerqueenchicago@gmail.com"

  def invitation_created(email, host)
    @email = email
    @host = host
    mail(to: @email, subject: "Join My Killer Queen Team")
  end

  def membership_requested(requester, team)
    @requester = requester
    mail(to: team.captain.email, subject: "Request to join #{team.name}")
  end

  def membership_rejected(requester, team)
    @team = team
    mail(to: requester.email, subject: "Request to join #{@team.name} rejected")
  end

  def membership_accepted(requester, team)
    @team = team
    mail(to: requester.email, subject: "Request to join #{@team.name} accepted!")
  end
end
