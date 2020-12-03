class SimulatorProcessesController < ApplicationController
  before_action :set_simulator_process, only: [:show, :update, :destroy]

  # GET /simulator_processes
  def index
    @simulator_processes = SimulatorProcess.all

    render json: @simulator_processes
  end

  # GET /simulator_processes/1
  def show
    render json: @simulator_process
  end

  # POST /simulator_processes
  def create
    @simulator_process = SimulatorProcess.new(simulator_process_params)

    if @simulator_process.save
      render json: @simulator_process, status: :created, location: @simulator_process
    else
      render json: @simulator_process.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /simulator_processes/1
  def update
    if @simulator_process.update(simulator_process_params)
      render json: @simulator_process
    else
      render json: @simulator_process.errors, status: :unprocessable_entity
    end
  end

  # DELETE /simulator_processes/1
  def destroy
    @simulator_process.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_simulator_process
      @simulator_process = SimulatorProcess.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def simulator_process_params
      params.require(:simulator_process).permit(:job_id, :is_beach)
    end
end
