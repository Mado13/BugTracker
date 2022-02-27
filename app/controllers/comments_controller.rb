class CommentsController < ApplicationController
  before_action :set_ticket, only: %I[new create]
  before_action :set_comment, only: %I[edit update destroy]

  def new
    @comment = @ticket.comments.new
  end

  def create
    # Due to difficulty using current_user(Devise) and ActionCable(Hotwire)
    # current_user was assigned to @user so it could pass in the view for the
    # comment section create method.
    @user = current_user
    @comment = @ticket.comments.new(comment_params)
    @comment.user = current_user
    @comment.ticket = @ticket

    # Using the respond to method because the App is using hotwire to make the comment section
    # reactive, and therefore needs a fallback redirection in case the turbo stream fails
    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to @ticket }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream
            .replace(@comment, partial: 'comments/form',
                               locals: { url: ticket_comments_path(@ticket) })
        end
      end
    end
  end

  def edit; end

  # Using the respond to method because the App is using hotwire to make the comment section
  # reactive, and therefore needs a fallback redirection in case the turbo stream fails
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream
        format.html { redirect_to @ticket }
      else
        # Renders an error message using turbo without re rendering the page
        format.turbo_stream do
          render turbo_stream: turbo_stream
            .replace(@comment, partial: 'comments/form',
                               locals: { url: comment_path(@comment) })
        end
      end
    end
  end

  def show; end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:ticket_id, :user_id, :comment)
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
