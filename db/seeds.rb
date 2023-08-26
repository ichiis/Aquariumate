# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'admin@admin',
   password: 'testtest'
)

end_users = EndUser.create!(
  [
    {email: 'olivia@example.com', name: 'Olivia', introduction: 'hello', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-end_user1.jpg"), filename:"sample-end_user1.jpg")},
    {email: 'james@example.com', name: 'James', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-end_user2.jpg"), filename:"sample-end_user2.jpg")},
    {email: 'lucas@example.com', name: 'Lucas', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-end_user3.jpg"), filename:"sample-end_user3.jpg")}
  ]
)

Post.create!(
  [
    {body: '海遊館へ行ってきました', images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")], end_user_id: end_users[0].id },
    {body: '水族館にシャチがいました', images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")], end_user_id: end_users[1].id },
    {body: '初めてシロイルカを見ました', images: [ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")], end_user_id: end_users[2].id }
  ]
)