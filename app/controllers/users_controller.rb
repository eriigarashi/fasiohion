class UsersController < ApplicationController
  # app/controllers/users_controller.rb
def show
  @user = User.find(params[:id])

  # タグ検索
  if params[:keyword].present?
    @tags = @user.created_tags.where("name LIKE ?", "%#{params[:keyword]}%")
  else
    @tags = @user.created_tags
  end

  # タグ絞り込み
  if params[:tag_ids].present?
    selected_ids = params[:tag_ids].select { |_id, v| v == "1" }.keys
    @blogs = @user.blogs.joins(:tags).where(tags: { id: selected_ids }).distinct
  else
    @blogs = @user.blogs
  end
end
end
