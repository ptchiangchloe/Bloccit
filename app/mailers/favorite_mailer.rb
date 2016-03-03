class FavoriteMailer < ApplicationMailer
  default from: 'ptchiang12@gmail.com'

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
    headers["In-Reply-To"] = "<posts/#{post.id}@your-app-name.example>"
    headers["References"] = "<posts/#{post.id}@your-app-name.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
