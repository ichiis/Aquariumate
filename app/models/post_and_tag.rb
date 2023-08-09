class PostAndTag < ApplicationRecord
  belongs_to :tag
  belongs_to :post
  
  with_options presence: true do
     validates :post_id
     validates :tag_id
  end
end
