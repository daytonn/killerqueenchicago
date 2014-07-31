class Invitation < ActiveRecord::Base
  after_create :send_invitation
  belongs_to :user
  validates :invitee_email, uniqueness: true
  scope :active, -> { where(accepted_at: nil) }

  def send_invitation
    InvitationMailer.invitation_created(invitee_email, user).deliver
  end
end
