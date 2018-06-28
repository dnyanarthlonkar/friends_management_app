class V1::FriendshipsController < ApplicationController
  def index
    raise ArgumentError, "Please provide Email Address" if params[:email].blank?
    user = User.find_by_email!(params[:email])
    friends = user.friendees.collect(&:email)
    count = friends.count
    json = {
      success: true,
      friends: friends,
      count: count
    }.to_json
    render json: json, status: :ok
  end

  def create
    emails = params[:friends].map(&:strip)
    if Friendship.make_friends!(emails)
      render json: {success: true}, status: :ok
    end
  end

  def common
    emails = params[:friends].map(&:strip)
    friends = Friendship.common_friends(emails).collect(&:email)
    count = friends.count
    json = {
      success: true,
      friends: friends,
      count: count
    }.to_json
    render json: json, status: :ok
  end
end
