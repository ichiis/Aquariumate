class FavoritePost < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  with_options presence: true do
     validates :end_user_id
     validates :post_id
  end
end
