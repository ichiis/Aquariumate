class FavoriteImage < ApplicationRecord
  belongs_to :post_image
  belongs_to :end_user
  
  with_options presence: true do
     validates :end_user_id
     validates :post_image_id
  end
end
