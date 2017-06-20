class CommentsController < ApplicationController
  def index
    if params[:author_id]
      comments = User.find(id: params[:author_id]).comments
    elsif params[:artwork_id]
      comments = Artwork.find(id: params[:artwork_id]).comments
    else
      comments = "No parameters specified"
    end

    render json: comments
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :author_id, :artwork_id)
  end
end
