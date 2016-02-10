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

unique_post do
  Post.create!(
  title:"my unique title"
  body:"my unique body"
)
end





puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
