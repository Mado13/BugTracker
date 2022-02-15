class TicketsController < ApplicationController
  def index
    if current_user.admin?
      @tickets = Ticket.all
    else
      user = User.find_by(id: params[:id])
      @tickets = Ticket.joins(:ticket_assignments)
                       .where(ticket_assignments: { developer_id: user }).all
    end
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])
  end
end
