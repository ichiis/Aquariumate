class Tag < ApplicationRecord
  has_many :post_and_tags,dependent: :destroy
  
  validates :tagname, presence: true
end
