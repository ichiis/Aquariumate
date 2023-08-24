class Post < ApplicationRecord
  belongs_to :end_user
  has_many :favorite_posts,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :post_and_tags,dependent: :destroy
  has_many :tags, through: :post_and_tags

  has_many_attached :images
  #画像の制限
  validate :images_length

  with_options presence: true do
     validates :end_user_id
     validates :body
  end
  validates :body,length:{maximum:500}

  def post_favorited_by?(end_user)
    favorite_posts.where(end_user_id: end_user.id).exists?
  end

  #タグの保存
  def save_tags(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags
    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end
    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << tag
    end
  end

  private
  #画像の枚数制限
  def images_length
    if images.length > 6
      errors.add(:images, "は6枚以内にしてください")
    end
  end
end