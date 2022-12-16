class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy join leave]
  before_action :authenticate_user!, except: %i[index show]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @technologies = Technology.all.pluck(:name).join(",")
  end

  def leave
    if Participant.where(user: current_user, edition: Edition.current_edition, project: @project).exists?
      Participant.where(user: current_user, edition: Edition.current_edition, project: @project).delete_all
      flash.now[:notice] = "You have left the project."
    end

    respond_to do |format|
      format.html { redirect_to project_url(@project) }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@project, partial: "projects/project", locals: { project: @project }) }
    end
  end

  def join
    if Participant.where(user: current_user, edition: Edition.current_edition).exists?
      flash.now[:alert] = "You're already in a team, leave it first please."
    else
      if @project.participants.count >= @project.participant_limit
        flash.now[:alert] = "Participant limit reached."
        return
      else
        flash.now[:success] = "Welcome to the team 🚀."
        role = Participant.where(project: @project, edition: Edition.current_edition).count == 0 ? :team_lead : :participant
        Participant.create(user: current_user, project: @project, edition: Edition.current_edition, role: role)
      end
    end

    respond_to do |format|
      format.html { redirect_to project_url(@project) }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@project, partial: "projects/project", locals: { project: @project }) }
    end
  end

  # GET /projects/1/edit
  def edit
    @technologies = Technology.all.pluck(:name).join(",")
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.owner = current_user


    respond_to do |format|
      if @project.save
        tech_stack = params[:project][:tech_stack].split(",").map(&:strip)
        # Make a transaction for creating tech stack
        ActiveRecord::Base.transaction do
          unless tech_stack.empty?
            tech_stack.each do |tech|
              technology = Technology.find_or_create_by(name: tech)
              TechStack.create(project: @project, technology: technology)
            end
          end
        end

        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)

        new_tech_stack = params[:project][:tech_stack].split(",").map(&:strip)
        @project.update_tech_stack new_tech_stack

        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.delete

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description, :participant_limit, :is_winner, :is_open)
    end
end
