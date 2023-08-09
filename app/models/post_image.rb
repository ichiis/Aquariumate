class PostImage < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  has_many :favorite_images
  
  has_many_attached :post_images
  
  with_options presence: true do
     validates :end_user_id
     validates :post_id
  end
end
