class BlogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @blogs = Blog.all
    if params[:tag_ids]
      @blogs = []
      params[:tag_ids].each do |key, value|
        @blogs += Tag.find_by(name: key).blogs if value == "1"
      end
      @blogs.uniq!
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
    # チェック状態があれば保持
    if params[:blog] && params[:blog][:tag_ids].present?
      @blog.tag_ids = params[:blog][:tag_ids].reject(&:blank?).map(&:to_i)
    end
  
    if params[:keyword].present?
      @tags = current_user.created_tags.where("name LIKE ?", "%#{params[:keyword]}%")
    else
      @tags = current_user.created_tags
    end
  end
  
  

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

    if @blog.save
      redirect_to user_path(current_user), notice: '投稿が完了しました！'
    else
      if params[:keyword].present?
        @tags = current_user.created_tags.where("name LIKE ?", "%#{params[:keyword]}%")
      else
        @tags = current_user.created_tags
      end
      render :new
    end
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to action: :index
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @itirans = @tag.tweets.all
  end

  private

  def blog_params
    params.require(:blog).permit(:start_time, :image, :kion, :content, tag_ids: [])
  end
end
