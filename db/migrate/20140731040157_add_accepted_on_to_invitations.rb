class AddAcceptedOnToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :accepted_at, :datetime
  end
end
