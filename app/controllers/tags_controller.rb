class TagsController < ApplicationController
  before_action :authenticate_user!
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
    @tags = current_user.created_tags
  end

  def search
    keyword = params[:keyword]
    puts "=== 検索キーワード: #{keyword}"  # ← 確認ログ
  
    if keyword.present?
      @tags = current_user.created_tags.where("name LIKE ?", "%#{keyword}%")
    else
      @tags = current_user.created_tags
    end
  
    @tag = Tag.new
    render :new
  end
  
  

  def create
    @tag = Tag.new(tag_params)
    @tag.user_id = current_user.id
    if @tag.save
      redirect_to new_tag_path, notice: 'タグを追加しました！'
    else
      render :new
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    
    if @tag.user_id == current_user.id
        @tag.destroy
        redirect_to new_tag_path, notice: 'タグを削除しました'
    else
        redirect_to new_tag_path, alert: '自分のタグしか削除できません'
    end

  end

  
  
  private
  def tag_params
    params.require(:tag).permit(:name, :image) # ← 写真もここでOK
  end
  



end
