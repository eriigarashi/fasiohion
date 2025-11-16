class Tag < ApplicationRecord
  has_one_attached :image 
  validates :name, presence: true
  belongs_to :user

  #Tagsテーブルから中間テーブルに対する関連付け
  has_many :blog_tag_relations, dependent: :destroy
  #Tagsテーブルから中間テーブルを介してArticleテーブルへの関連付け
  has_many :blogs, through: :blog_tag_relations, dependent: :destroy
  has_many :users, -> { distinct }, through: :blogs
  
end
