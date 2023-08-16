class FavoriteImage < ApplicationRecord
  #belongs_to :post_image
  belongs_to :end_user
  
  with_options presence: true do
     validates :end_user_id
     validates :attachments_id
  end
end
