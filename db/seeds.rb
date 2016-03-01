require "random_data"
50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

puts "#{Post.count}"
unique_post = Post.find_or_create_by(title: "A unique title", body: "A unique body")
puts "#{Post.count}"


puts "#{Comment.count}"
Comment.find_or_create_by(post: unique_post, body:"A unique body")
puts "#{Comment.count}"

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
