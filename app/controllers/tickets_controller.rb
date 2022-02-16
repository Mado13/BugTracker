class TicketsController < ApplicationController



  def index
    # Populating @tickets with the appropriate data according to user role.
    @tickets =
      case current_user.role
      when 'Admin'
        Ticket.all
      # All the tickets from all the projects that the user is assigned as project manager
      when 'Project Manager'
        Ticket.project_manager_tickets(current_user.id)
      # All the tickets that the devloper has tickets assigned to him.
      when 'Lead Developer'
        Ticket.lead_developer_data(current_user.id)
      # all the tickets from all the projects the the current user is assigned as lead developer
      else
        Ticket.developer_tickets(current_user.id)
      end
  end

  def new
    @lead_developers = User.users_by_role('Lead Developer')
    @ticket = TicketDecorator.new(Ticket.new(project_id: params[:project_id]))
  end

 def create
    # If user tries to modify its id or project_id in the inspect tool they'll see an error message, otherwise project will be created

    if (params[:ticket][:lead_developer_id].to_i == current_user.id || @user.admin?) && params[:id] == ticket_params[:project_id]
      @ticket = Ticket.create(ticket_params)
      if @ticket.valid?
        redirect_to ticket_path(@ticket)
      else
        @lead_developers = User.users_by_role("Lead Developer")
        render :new
      end
    else
      flash.now.alert = "Logged user or project id doesn't match the id of the user submitting the form or the expected project, please try again."
      if current_user.role.name == "Lead Developer"
        @ticket = Ticket.new(
          title: params[:ticket][:title],
          description: params[:ticket][:description],
          priority: params[:ticket][:priority],
          category: params[:ticket][:category],
          status: "Open",
          lead_developer: current_user,
          project_id: params[:id])
      else
        @ticket = Ticket.new(
          title: params[:ticket][:title],
          description: params[:ticket][:description],
          priority: params[:ticket][:priority],
          category: params[:ticket][:category],
          status: "Open",
          project_id: params[:id])
      end
      @lead_developers = User.users_by_role("Lead Developer")
      render :new
    end
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])
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

end
