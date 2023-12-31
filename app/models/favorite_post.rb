class FavoritePost < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  validates_uniqueness_of :post_id, scope: :end_user_id

  with_options presence: true do
     validates :end_user_id
     validates :post_id
  end
end