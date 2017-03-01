class CommentsController < ApplicationController
  after_action :verify_authorized

  def create
    @comment = Comment.new(comments_params)
    authorize @comment
    if @comment.save
      redirect_to post_path(params[:post_id]), notice: 'Comment successfully created'
    else
      redirect_to post_path(params[:post_id]), alert: @comment.errors.values.join(', ')
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    authorize @comment

    if @comment.destroy
      redirect_to post_path(post), notice: 'Comment successfully deleted'
    else
      redirect_to post_path(post), alert: 'Can not delete the comment'
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
