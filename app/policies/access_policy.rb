class AccessPolicy
  include AccessGranted::Policy

    def configure
    role :moderator, proc { |user| user.moderator? } do
      can [:read, :create, :update], Post
      can [:read, :update], Topic
    end

    role :admin, proc { |user| user.admin? } do
      can :manage, Post
      can :manage, Topic
    end

    role :member, proc { |user| user.member? } do
      can :manage, Topic do |topic, user|
        topic.author == user
      end
      can :manage, Post do |post, user|
        post.author == user
      end
    end

    role :guest do
      can :read, Post
      can :read, Topic
    end
  end
end
