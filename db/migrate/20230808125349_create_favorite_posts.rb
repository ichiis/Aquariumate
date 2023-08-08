class CreateFavoritePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_posts do |t|
      t.integer :end_user_id, null:false
      t.integer :post_id, null:false
      t.timestamps
    end
  end
end
