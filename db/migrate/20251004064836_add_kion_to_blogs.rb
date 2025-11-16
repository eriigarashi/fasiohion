class AddKionToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :kion, :float
    add_column :blogs, :review, :text
  end
end
