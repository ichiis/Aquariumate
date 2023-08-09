class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  
  with_options presence: true do
     validates :comment
     validates :end_user_id
     validates :post_id
  end
end
