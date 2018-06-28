class V1::FollowsController < ApplicationController
  def create
    requestor = User.find_by_email!(params[:requestor])
    target = User.find_by_email!(params[:target])
    if requestor.subscribe_to!(target)
      render json: {success: true}, status: :ok
    end
  end

  def index
    raise ArgumentError, "An email address should be provided" if params[:sender].blank?
    raise ArgumentError, "A text should be provided" if params[:text].blank?
    user = User.find_by_email!(params[:sender])
    text = params[:text]
    recipients = (user.subscribers + User.mentioned_in(text)).uniq - user.blockers
    json = {
      success: true,
      recipients: recipients.collect(&:email)
    }.to_json
    render json: json, status: :ok
  end
end
