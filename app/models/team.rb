class Team < ActiveRecord::Base
  has_many :members, class_name: "User"
  belongs_to :captain, class_name: "User", foreign_key: "captain_id"

  def full?
    members.size == 5
  end
end
