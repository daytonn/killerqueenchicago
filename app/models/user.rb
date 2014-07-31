class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username, presence: true

  belongs_to :team
  has_many :invitations

  def on_team?
    team.present?
  end

  def no_team?
    team.nil?
  end

  def captain?
    team.captain.id == id if team.present?
  end

  def teammates
    @teammates ||= team.members.reject { |teammate| teammate.id == id }
  end
end
