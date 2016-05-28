class CommentsController < ApplicationController
	def create
		@city = City.find(params[:city_id])
	    @comment = @city.comments.create(comment_params)
	    redirect_to city_path(@city)
 	end
 
private
   	def comment_params
   		params.require(:comment).permit(:commenter, :body)
   	end
end
