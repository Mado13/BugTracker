class TicketsController < ApplicationController
  def index
    if current_user.admin?
      @tickets = Ticket.all
    else
      user = User.find_by(id: params[:id])
      @assigns = TicketAssignment.joins(:ticket).where(developer_id: current_user.id).all
    end
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])
  end
end
