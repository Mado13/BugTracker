class CommentPresenter
  def initialize(comment, current_user, template)
    @comment = comment
    @user = current_user
    @template = template
  end

  # Returns the view template and then creates a helper as h. when want to call
  # Rails helpers on the view, and matching the pattern to the one of Draper
  # with the decorators
  def h
    @template
  end

  def edit_tags
    if @user.id == @comment.user_id
      h.render inline: "<%= link_to 'Edit', edit_comment_path(#{@comment.id}) %>
                        <%= link_to 'Delete', comment_path(#{@comment.id}), method: :delete %>"
    end
  end
end
