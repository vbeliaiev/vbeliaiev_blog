class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def create?
    !!user
  end

  def destroy?
    !!user && (user == comment.author || user == comment.post.author)
  end

end
