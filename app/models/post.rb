class Post < ApplicationRecord
  belongs_to :end_user
  has_many :post_images,dependent: :destroy
  # has_many :fovorite_posts,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :post_and_tags,dependent: :destroy
  
  with_options presence: true do
     validates :end_user_id
     validates :title
     validates :body
  end
  validates :title,length:{maximum:50}
  validates :body,length:{maximum:300}
end
