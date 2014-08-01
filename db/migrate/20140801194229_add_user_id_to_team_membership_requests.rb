class AddUserIdToTeamMembershipRequests < ActiveRecord::Migration
  def change
    remove_column :team_membership_requests, :requester_id
    add_column :team_membership_requests, :user_id, :integer
  end
end
