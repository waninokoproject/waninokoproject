class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :set_search

  def set_search
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order("id DESC")
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def user_authentication
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts")
    end
  end

  def no_entry
    if @current_user == nil
      flash[:notice] = "権限がありません。ねぇ。ちゃんとして"
      redirect_to("/")
    end
  end

  

  protect_from_forgery with: :exception
end
