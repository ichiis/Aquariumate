class CreatePostAndTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_and_tags do |t|
      t.integer :post_id, null:false
      t.integer :tag_id, null:false
      t.timestamps
    end
  end
end
