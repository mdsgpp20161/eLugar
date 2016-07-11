class CommentsController < ApplicationController
  def create
    @city = City.find(params[:city_id])
      @comment = @city.comments.create(comment_params)
      redirect_to city_path(@city)
  end

# 	def destroy
#	    @city = City.find(params[:city_id])
#	    @comment = @city.comments.find(params[:id])
#	    @comment.destroy
#	    redirect_to city_path(@city)
#  	end
#
#  	def edit
#  		@comment = Comment.find(params[:id])
#  		@city = City.find(params[:city_id])
#  	end

private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
