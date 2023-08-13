class PostImage < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  has_many :favorite_images
  
  has_many_attached :images
  
  with_options presence: true do
     validates :end_user_id
     validates :post_id
  end
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end 
end
