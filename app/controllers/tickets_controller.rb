class TicketsController < ApplicationController
  before_action :set_ticket, only: %I[show edit update]

  def index
    @tickets = policy_scope(Ticket.all)
  end

  def new
    authorize Ticket
    @ticket = Ticket.new(project_id: params[:project_id])
  end

  def edit
    authorize @ticket
  end

  def update
    authorize @ticket
    if @ticket.update(ticket_params)
      redirect_to ticket_path(@ticket)
      flash[:notice] = "Ticket #{@ticket.title} Updated!"
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
      flash[:notice] = "Ticket: #{@ticket.title} Created Successfully"
    else
      @ticket ||= Ticket.new
      render :new
    end
  end

  def show
    # Due to difficulty using current_user(Devise) and ActionCable(Hotwire)
    # current_user was assigned to @user so it could pass in the view for the
    # comment section create method.
    @user = current_user
    @comment = Comment.new(ticket: @ticket, user: current_user)
    @ticket_comments = Comment.where(ticket_id: @ticket.id).order('updated_at DESC')
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

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
