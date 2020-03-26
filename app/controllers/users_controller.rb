class UsersController < ApplicationController
  before_action :no_entry, only: [:show, :edit, :update, :logout]
  before_action :user_authentication, only: [:login, :new, :create, :authentication]

  def new
    @user = User.new
  end

  #新規作成
  def create
    @user = User.new(name: params[:name], mail: params[:mail], passwd: params[:passwd])
    @user.user_image = "1.jpg"  #userのデフォルトの画像です。いまはおおなかきみことおんなじだけど。
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/posts")
    else
      @error_message = "メールアドレスまたはパスワードが空白です。ねぇ。ちゃんとして。"
      render("users/new")
    end
  end

  #個人のページ
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  #個人ページの編集
  def edit
    check_user
    @user = User.find_by(id: params[:id])
  end

  #loginフォーム
  def login
  end

  #個人ページの編集処理
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.mail = params[:mail]
    @user.passwd = params[:passwd]
    if params[:image]
      @user.user_image = "#{@user.id}.jpg"
      image = params[:image]  #画像を変数に代入
      File.binwrite("public/users_image/#{@user.user_image}", image.read)
    end

    if @user.save
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  #ユーザー認証
  def authentication
    user = User.find_by(mail: params[:mail], passwd: params[:passwd])
    if user
      session[:user_id] = user.id
      redirect_to("/posts")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @mail = params[:mail]
      @passwd = params[:passwd]
      render("users/login")
    end
  end

  #logout
  def logout
    session[:user_id] = nil
    redirect_to("/")
  end

  private
  
  def check_user
    if @current_user != User.find_by(id: params[:id])
      redirect_to("/posts")
    end
  end
end
