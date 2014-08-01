class CreateTeamMembershipRequests < ActiveRecord::Migration
  def change
    create_table :team_membership_requests do |t|
      t.integer :requester_id
      t.integer :team_id
      t.datetime :accepted_at
      t.datetime :rejected_at

      t.timestamps
    end
  end
end
