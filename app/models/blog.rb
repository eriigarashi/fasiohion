class Blog < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :blog_tag_relations, dependent: :destroy
    has_many :tags, through: :blog_tag_relations, dependent: :destroy
end
