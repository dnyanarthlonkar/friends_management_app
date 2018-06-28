class Block < ApplicationRecord
  after_create_commit :unfriend_and_unfollow_blocked_user

  belongs_to :blocker, class_name: "User", foreign_key: "blocker_id"
  belongs_to :blockee, class_name: "User", foreign_key: "blockee_id"

  validates :blocker_id, :blockee_id, presence: true
  validates :blocker_id, uniqueness: {scope: :blockee_id}

  def unfriend_and_unfollow_blocked_user
    blockee = self.blockee
    blocker = self.blocker
    Follow.where(follower: blockee, followee: blocker).destroy_all
  end
end
