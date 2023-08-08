class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      t.integer :end_user_id, null:false
      t.integer :post_id, null:false
      t.timestamps
    end
  end
end
