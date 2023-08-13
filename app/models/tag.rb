class Tag < ApplicationRecord
  has_many :post_and_tags,dependent: :destroy
  has_many :posts, through: :post_and_tags
  
  validates :tag_name, presence:true, length:{maximum:20}
end
