class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @invitations = Invitation.all
  end

  def show
  end

  def new
    @invitation = Invitation.new
  end

  def edit
  end

  def create
    @invitation = Invitation.new(invitation_params.merge(captain_id: current_user.id))
    @invitation.members << current_user

    if @invitation.save
      redirect_to dashboard_path, notice: 'Invitation was successfully created.'
    else
      render :new
    end
  end

  def update
    if @invitation.update(invitation_params.merge(captain_id: current_user.id))
      redirect_to @invitation, notice: 'Invitation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @invitation.destroy
    redirect_to dashboard_path, notice: 'Invitation was successfully destroyed.'
  end

  private
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    def invitation_params
      params.require(:invitation).permit(:name)
    end
end
