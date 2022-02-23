class CommentsController < ApplicationController
  before_action :set_ticket, only: %I[new create]

  def new
    @comment = @ticket.comments.new
  end

  def create
    @comment = @ticket.comments.new(comment_params)
    @comment.user = current_user
    @comment.ticket = @ticket
    @comment.save!

    respond_to do |format|
      # format.turbo_stream
      format.html { redirect_to @ticket }
    end
  end



  # def create
  #   # If a new comment belongs to the logged in user and the expected ticket id, create the comment.
  #   # Otherwise, sent a flash message without deleting previous information that the user has filled out
  #   if comment_params[:user_id].to_i == current_user.id && params[:ticket_id] == comment_params[:ticket_id]
  #     @new_comment = Comment.create(comment_params)
  #     if @new_comment.valid?
  #       redirect_to ticket_path(params[:ticket_id])
  #     else
  #       @ticket = Ticket.find(params[:ticket_id])
  #       @ticket_comments = @ticket.comments
  #       render "tickets/show"
  #     end
  #   else
  #     flash.now.alert = "Unauthorised action, user id or ticket id are not the expected ones"
  #     @ticket = Ticket.find(params[:ticket_id])
  #     @new_comment = Comment.new(ticket: @ticket, user: current_user, message: params[:comment][:message])
  #     @ticket_comments = @ticket.comments
  #     render "tickets/show"
  #   end
  # end

  private
  def comment_params
    params.require(:comment).permit(:ticket_id, :user_id, :comment)
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
