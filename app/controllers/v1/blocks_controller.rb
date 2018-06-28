class V1::BlocksController < ApplicationController
  def create
    requestor = User.find_by_email!(params[:requestor])
    target = User.find_by_email!(params[:target])
    if requestor.block!(target)
      render json: {success: true}, status: :ok
    end
  end
end
