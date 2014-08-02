class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @team_request = TeamMembershipRequest.includes(:team).open.find_by(requester: current_user)
    if current_user.captain?
      @membership_requests = TeamMembershipRequest.includes(:requester).open.where(team: current_user.team)
    end
  end

  def calendar
  end
end
