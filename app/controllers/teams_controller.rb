class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :invite]
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
    @team = Team.new(team_params)

    if @team.save
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def update
    if @team.update(team_params)
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
    params[:invitees].each do |email|
      Invitation.create(invitee_email: email, user_id: current_user.id)
    end
    redirect_to dashboard_path, notice: "Invitations sent"
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :captain_id)
    end
end
