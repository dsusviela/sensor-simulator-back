require 'test_helper'

class SimulatorProcessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @simulator_process = simulator_processes(:one)
  end

  test "should get index" do
    get simulator_processes_url, as: :json
    assert_response :success
  end

  test "should create simulator_process" do
    assert_difference('SimulatorProcess.count') do
      post simulator_processes_url, params: { simulator_process: { is_beach: @simulator_process.is_beach, job_id: @simulator_process.job_id } }, as: :json
    end

    assert_response 201
  end

  test "should show simulator_process" do
    get simulator_process_url(@simulator_process), as: :json
    assert_response :success
  end

  test "should update simulator_process" do
    patch simulator_process_url(@simulator_process), params: { simulator_process: { is_beach: @simulator_process.is_beach, job_id: @simulator_process.job_id } }, as: :json
    assert_response 200
  end

  test "should destroy simulator_process" do
    assert_difference('SimulatorProcess.count', -1) do
      delete simulator_process_url(@simulator_process), as: :json
    end

    assert_response 204
  end
end
