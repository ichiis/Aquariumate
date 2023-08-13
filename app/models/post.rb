class Post < ApplicationRecord
  belongs_to :end_user
  has_many :post_images,dependent: :destroy
  # has_many :fovorite_posts,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :post_and_tags,dependent: :destroy
  has_many :tags, through: :post_and_tags

  has_many_attached :images

  accepts_nested_attributes_for :post_images, allow_destroy: true, reject_if: :all_blank

  with_options presence: true do
     validates :end_user_id
     validates :title
     validates :body
  end
  validates :title,length:{maximum:50}
  validates :body,length:{maximum:300}

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
end
