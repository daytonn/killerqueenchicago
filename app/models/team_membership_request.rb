class TeamMembershipRequest < ActiveRecord::Base
  after_create :send_request
  after_save :send_rejection, if: :rejected?
  after_save :send_acceptance, if: :accepted?
  belongs_to :requester, class_name: "User", foreign_key: "user_id"
  belongs_to :team
  validates :user_id, presence: true
  validates :team_id, presence: true
  scope :open, -> { where(accepted_at: nil, rejected_at: nil) }

  def send_request
    TeamMailer.membership_requested(requester, team).deliver
  end

  def send_rejection
    TeamMailer.membership_rejected(requester, team).deliver
  end

  def send_acceptance
    TeamMailer.membership_accepted(requester, team).deliver
  end

  def accepted?
    accepted_at.present?
  end

  def rejected?
    rejected_at.present?
  end
end
