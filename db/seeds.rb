# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
PostTag.delete_all
Tag.delete_all
Post.delete_all
User.delete_all

users = User.create!([
    { name: 'John Doe', email: 'jdoe@gmail.com', password: 'password1' },
    { name: 'Peter Parker', email: 'pparker@gmail.com', password: 'password2' },
    { name: 'Bruce Wayne', email: 'bwayne@gmail.com', password: 'password3' },
    { name: 'Clark Kent', email: 'ckent@gmail.com', password: 'password4' },
    { name: 'Tony Stark', email: 'tstark@gmail.com', password: 'password5' }
])

index = 1
posts = users.flat_map do |user|
    [
        { title: "Post #{index}", content: "Content #{index}", published_at: Time.now, user_id: user.id },
        { title: "Post #{index + 1}", content: "Content #{index + 1}", published_at: Time.now, user_id: user.id }
    ].tap { index += 2 }
end

Post.create!(posts)

parent_post = Post.third
Post.create!(title: 'Child Post', content: 'Child Content', published_at: Time.now, user_id: User.first.id, parent_id: parent_post.id)
Post.create!(title: 'Child Post 2', content: 'Child Content 2', published_at: Time.now, user_id: User.first.id, parent_id: parent_post.id)

tags = Tag.create!([
    { name: 'Tag 1' },
    { name: 'Tag 2' },
    { name: 'Tag 3' },
    { name: 'Tag 4' },
    { name: 'Tag 5' }
])

Post.all.each_with_index do |post, index|
  tag = tags[index % tags.size]
  PostTag.create!(post_id: post.id, tag_id: tag.id)
end