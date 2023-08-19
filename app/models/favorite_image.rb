class FavoriteImage < ApplicationRecord
  belongs_to :post
  belongs_to :attachment
  belongs_to :end_user
  
  validates_uniqueness_of :image_id, scope: :end_user_id
  
  with_options presence: true do
     validates :end_user_id
     validates :image_id
  end
end
