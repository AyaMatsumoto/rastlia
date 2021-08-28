class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: "desc")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    flash[:alert] = nil
    @post = Post.new
  end

  def confirm
    if params[:new]
      @post = Post.new(post_params)
      render :new if @post.invalid? #入力項目に空のものがあれば入力画面に遷移
    elsif params[:edit]
      @post = Post.find(params[:id])
    end

    @vurl = @post.video_url
    @curl = @post.channel_url
    flash[:alert] = ""
    url = "https://www.youtube.com/"

    if !@vurl.try(:include?, url)
      flash[:alert] += "動画URLの形式が正しくありません。<br>"
    end

    if !@curl.blank? && !@curl.try(:include?, url)
      flash[:alert] += "チャンネルURLの形式が正しくありません。<br>"
    end

    if !flash[:alert].blank?
      render :new and return
    end
  end

  def create
    @post = Post.new(post_params)

    if params[:back]
      flash[:alert] = nil
      render :new and return
      redirect_to root_path
    end

    if @post.save
      flash[:alert] = "新規投稿を行いました。"
      redirect_to posts_path
    else
      render "new"
    end
  end

  def edit
    flash[:alert] = nil
    @post = Post.find(params[:id])
  end

  # def update
  #   @post = Post.find(params[:id])

  #   if params[:back]
  #     flash[:alert] = nil
  #     render :new and return
  #     redirect_to root_path
  #   end

  #   if params[:password] == @post.password
  #     if @post.save
  #       flash[:alert] = "投稿の修正を行いました。"
  #       redirect_to posts_path
  #     else
  #       render "edit"
  #     end
  #   else
  #     flash[:alert] = "パスワードが正しくありません。"
  #     render "edit"
  #   end
  # end

  def delete
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if params[:password] == @post.password
      @post.destroy
      redirect_to posts_path
    else
      flash[:alert] = "パスワードが正しくありません。"
      render :delete
    end
  end

  private

  def post_params
    params.permit(post: {}).require(:post)
    #params.permit(:name, :video_url, :channel_url, :password, :content)
  end
end
