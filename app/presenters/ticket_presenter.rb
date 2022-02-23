class TicketPresenter
  def initialize(ticket, current_user, template)
    @ticket = ticket
    @template = template
    @user = UserDecorator.new(current_user)
  end

  def h
    @template
  end

  # if user is admin or project manager there will be a select box for lead developer
  # on creation of new ticket, if user is lead developer it will set user by default
  # as lead developer
  def lead_developer_select_tag
    if @user.admin? || @user.project_manager?
      h.select_tag 'ticket[lead_developer_id]',
                   h.options_from_collection_for_select(User.users_by_role('Lead Developer'), :id, :email),
                   class: 'form-control col-md-4 col-form-label text-md-right',
                   prompt: 'Select Lead Developer'
    elsif @user.lead_developer?
      h.hidden_field_tag 'ticket[lead_developer_id]', @user.id
    end
  end

  # if ticket is new the status will set as 'Open' by default, otherwise
  # there will be a select box for ticket status.
  def hidden_tag_status
    if @ticket.new_record?
      h.hidden_field_tag 'ticket[status]', 'Open'
    else
      h.select_tag 'ticket[status]',
                   h.options_for_select(%w[open close]),
                   class: 'form-control col-md-4 col-form-label text-md-right',
                   prompt: 'Ticket Status'
    end
  end
end
