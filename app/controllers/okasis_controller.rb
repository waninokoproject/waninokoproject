class OkasisController < ApplicationController
  before_action :no_entry
  before_action :chack_admin, only: [:create, :new, :destroy]

  def index
    @q = Okasi.ransack(params[:q])
    @okasis = @q.result(distinct: true).order(release_date: "DESC")
  end

  def new
    @okasi = Okasi.new
  end

  def show
    @okasi = Okasi.find_by(id: params[:id])
    @post = Post.new
    @q = Post.ransack({"tweet_cont"=>@okasi.name})
    @posts = @q.result(distinct: true).order(id: "DESC")
  end

  def create
    @okasi = Okasi.new(okasi_params)
    @okasi.save #ここで保存しないとidが発行されないっぽい。謎
    @okasi.okasi_image = "#{@okasi.id}.jpg"
    image = params[:okasi][:okasi_image]
    File.binwrite("public/Okasi/#{@okasi.okasi_image}", image.read)
    if @okasi.save
      redirect_to okasis_url
    end
  end

  def destroy
    okasi = Okasi.find(params[:id])
    okasi.destroy
    #okasi.save
    redirect_to(okasis_path)
  end

  private

  def okasi_params
    params.require(:okasi).permit(:name, :price, :content, :okasi_attribute, :company, :release_date)
  end

  def chack_admin
    if @current_user.id != 6
      redirect_to(okasis_path)
    end
  end
end
