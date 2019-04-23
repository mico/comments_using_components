class CommentsController < ApplicationController
  # POST /comments
  def create
    @commentable = get_commentable
    @comment = Comment.new(comment_params.merge(commentable: @commentable))

    if @comment.save
      redirect_to [@commentable, @comment], notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:text)
  end

  def get_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        # in my case, 'friendly' worthy models will be worked on
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
