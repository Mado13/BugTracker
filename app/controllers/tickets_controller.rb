class TicketsController < ApplicationController
  before_action :authorize_ticket, only: %I[new edit]
  before_action :set_ticket, only: %I[show edit update]

  def index
    @tickets = policy_scope(Ticket.all)
  end

  def new
    @ticket = Ticket.new(project_id: params[:project_id])
  end

  def edit
  end

  def update
    authorize @ticket
    if @ticket.update(ticket_params)
      redirect_to ticket_path(@ticket)
      flash[:alert] = "Ticket #{@ticket.title} Updated!"
    else
      @ticket ||= Ticket.new
      render :new
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    authorize @ticket
    if @ticket.save
      redirect_to ticket_path(@ticket)
      flash[:alert] = "Ticket #{@ticket.title} Created Successfully"
    else
      @ticket ||= Ticket.new
      render :new
    end
  end

  def show
    # @new_comment = Comment.new(ticket: @ticket, user: current_user)
    # @ticket_comments = Comment.all.select { |c| c.ticket == @ticket }
  end

  private

  def ticket_params
    params.require(:ticket).permit(
      :title,
      :description,
      :lead_developer_id,
      :project_id,
      :priority,
      :status,
      :category,
      developer_ids: []
    )
  end

  def authorize_ticket
    authorize Ticket
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
