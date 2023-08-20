class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_posts, dependent: :destroy
  has_many :favorite_images, dependent: :destroy
  
  has_one_attached :profile_image
  
  validates :name, presence: true
  validates :email, uniqueness: true
  
  validates :introduction,length:{maximum:50}
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |end_user|
      end_user.password = SecureRandom.urlsafe_base64
      end_user.name="ゲスト"
      end_user.is_deleted="false"
    end
  end
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  #検索方法　部分一致
  def self.search_for(word)
    EndUser.where('name LIKE ?', '%'+word+'%')
  end
end
