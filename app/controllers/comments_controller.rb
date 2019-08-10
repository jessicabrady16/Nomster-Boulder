class CommentsController < ApplicationController
    before_action :authenticate_user!

  
  def create
    @place = Place.find(params[:place_id])
    @comment= @place.comments.create(comment_params.merge(user: current_user))
    if @comment.valid?
    redirect_to place_path(@place)
    else 

      return render plain: ' Be kind! Please rewind and enter a comment AND/OR a rating! We cannot "Nom" air!', status: :forbidden
      #render :new, status: :unprocessable_entity 
      
    end
  end
   
               def destroy  
    @place = Place.find(params[:place_id])
    @comment= Comment.find(params[:id])
    if @comment.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
  end
    @comment.destroy
    redirect_to place_path(@place)

end



private 

def comment_params
    params.require(:comment).permit(:message, :rating)
end

end