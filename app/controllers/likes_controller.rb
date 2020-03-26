class LikesController < ApplicationController
  before_action :no_entry, only: [:create, :destroy]

  def create
    @like = Like.new(post_id: params[:post_id], user_id: @current_user.id)
    if @like.save
      redirect_back(fallback_location: posts_path)
      #reidrect_to posts_index_path
    end
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: @current_user.id)
    @like.destroy
    redirect_back(fallback_location: posts_path)
  end
end
