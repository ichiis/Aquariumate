class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :post_images, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_posts, dependent: :destroy
  has_many :favorite_post_images, dependent: :destroy
  
  has_one_attached :profile_image
  
  validates :name, presence: true
end
