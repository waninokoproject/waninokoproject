class PostsController < ApplicationController
  before_action :no_entry

  def index
    @post = Post.new
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(id: "DESC")
    @user = User.all
    @rank = Like.where(user_id: @current_user.id)

    recUser = []
    @Recommended = []
    count = 0

    @rank.each do |a|
      b = User.find_by(id: Post.find_by(id: a.post_id).user_id)
      if b.id != @current_user.id
        flg = 0

        recUser.each do |var|
          if var[:id] == b.id
            flg = 1
            var[:count] += 1
            break
          end
        end

        if flg == 0
          recUser.push({id:b.id, count: 1})
          count += 1
        end
      end
    end

    for i in 0..count-1
      for j in i+1..count-1
        if  recUser[i][:count] > recUser[j][:count]
          tmp =  recUser[i];
          recUser[i] = recUser[j];
          recUser[j] = tmp;
        end
      end
    end

    if count>3
      recUser.shift(count-3)
    end
    recUser.each do |user|
      @Recommended.push(User.find_by(id: user[:id]))
    end
  end

  def tweet
    @post = Post.new
  end

  def create
    @post = Post.new(tweet: params[:tweet], user_id: @current_user.id)
    @posts = Post.all.order("id DESC")
    if @post.save
      redirect_back(fallback_location: posts_path)
    else
      render("posts/index")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    @post.save

    redirect_to(posts_path)
  end
end
