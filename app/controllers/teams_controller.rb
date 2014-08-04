class TeamsController < ApplicationController
  before_action :set_team, only: [
    :show,
    :edit,
    :update,
    :destroy,
    :invite,
    :join_team,
    :accept,
    :reject
  ]
  before_action :authenticate_user!

  def index
    @teams = Team.all
  end

  def show
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params.merge(captain_id: current_user.id))
    @team.memebers << current_user

    if @team.save
      redirect_to dashboard_path, notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def update
    if @team.update(team_params.merge(captain_id: current_user.id))
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'Team was successfully destroyed.'
  end

  def invite
  end

  def send_invites
    if params[:invitees]
      params[:invitees].each do |email|
        Invitation.create(invitee_email: email, user_id: current_user.id)
      end
      redirect_to dashboard_path, notice: "Invitations sent"
    else
      redirect_to "invite"
    end
  end

  def join
    @teams = Team.all
  end

  def join_team
    TeamMembershipRequest.create(requester: current_user, team: @team)
    redirect_to dashboard_path, notice: "Request sent"
  end

  def accept
    membership_request = TeamMembershipRequest.includes(:requester).find_by(id: params[:request_id])
    if membership_request
      membership_request.update_attributes(accepted_at: Time.zone.now)
      @team.members << membership_request.requester
      redirect_to dashboard_path, notice: "You've acceptead #{membership_request.requester.username}'s request, they are now on your roster!"
    else
      redirect_to dashboard_path, alert: "Membership request not found"
    end
  end

  def reject
    membership_request = TeamMembershipRequest.includes(:requester).find_by(id: params[:request_id])
    if membership_request
      membership_request.update_attributes(rejected_at: Time.zone.now)
      redirect_to dashboard_path, notice: "You've rejected #{membership_request.requester.username}'s request!"
    else
      redirect_to dashboard_path, alert: "Membership request not found"
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name)
    end
end
