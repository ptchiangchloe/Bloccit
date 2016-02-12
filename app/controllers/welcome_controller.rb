class WelcomeController < ApplicationController
  def index
    @posts = Post.all
    @post.each_with_index do |post, index|
      if index % 5 == 0
        post.title = "SPAM"
      end
    end
  end

  def about
  end

  def contact
  end

  def faq
  end
end
