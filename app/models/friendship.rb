class Friendship < ApplicationRecord
  belongs_to :friender, class_name: "User", foreign_key: "friender_id"
  belongs_to :friendee, class_name: "User", foreign_key: "friendee_id"

  validates :friender_id, :friendee_id, presence: true
  validates :friender_id, uniqueness: {scope: :friendee_id}

  def self.make_friends!(emails)
    user_1 = User.find_by_email(emails.first)
    user_2 = User.find_by_email(emails.second)

    raise ArgumentError, "Too many email addresses. Only accepts two." if emails.count != 2
    raise ArgumentError, "The two email addresses are the same." if emails.first == emails.second
    raise ActiveRecord::RecordNotFound, "User not found for email address: '#{emails.first}'." if user_1.blank?
    raise ActiveRecord::RecordNotFound, "User not found for email address: '#{emails.second}'." if user_2.blank?
    raise ArgumentError, "You have been blocked!" if user_1.is_blocked_by?(user_2) || user_2.is_blocked_by?(user_1)

    Friendship.create!(friender: user_1, friendee: user_2)
    Friendship.create!(friender: user_2, friendee: user_1)
    return true
  end

  def self.common_friends(emails)
    user_1 = User.find_by_email(emails.first)
    user_2 = User.find_by_email(emails.second)

    raise ArgumentError, "Too many email addresses. Only accepts 2." if emails.count != 2
    raise ArgumentError, "The 2 email addresses are the same." if emails.first == emails.second
    raise ActiveRecord::RecordNotFound, "User not found for email address: '#{emails.first}'." if user_1.blank?
    raise ActiveRecord::RecordNotFound, "User not found for email address: '#{emails.second}'." if user_2.blank?

    common_friends = user_1.friendees & user_2.friendees
    return common_friends
  end
end
