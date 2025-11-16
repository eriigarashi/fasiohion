class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_one_attached :image 
  has_many :blogs, dependent: :destroy
  has_many :tags, -> { distinct }, through: :blogs
  # 🔽 自分が作成したタグ（←これを追加！）
  has_many :created_tags, class_name: 'Tag', foreign_key: 'user_id', dependent: :destroy

  validates :name, presence: true 
  validates :profile, length: { maximum: 200 } 
      
end
