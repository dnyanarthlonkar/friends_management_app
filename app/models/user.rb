class User < ApplicationRecord
	has_many :friendships, dependent: :destroy, foreign_key: "friender_id"
    has_many :friendees, :through => :friendships, foreign_key: "friender_id"

    has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friendee_id", dependent: :destroy
    has_many :frienders, :through => :inverse_friendships, foreign_key: "friendee_id"
 
    validates :email, presence: true, uniqueness: true
end
