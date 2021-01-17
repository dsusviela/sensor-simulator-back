class BeachSimulator
  def initialize
    @current_people = 0
    @beach_capacity = 10000
    @ticks = 0
  end

  def call
    Rails.logger.info "Running Beach Simulator..."
    process = SimulatorProcess.find_by(is_beach: true)
    if process.present?
      threads = []

      BeachSensor.where.not(sensor_type: :personas).each do |beach_sensor|
        Rails.logger.info "Found an active sensor"
        threads << Thread.new { beach_sensor.generate_and_send_data(@ticks) }
      end

      threads << Thread.new { simulate_people_in_beach(@ticks) }

      threads.each do |thread|
        thread.join
      end
      @ticks += 1
    else
      Rails.logger.error "Simulator process running without data instance"
    end
  end

  def simulate_people_in_beach(ticks)
    BeachSensor.where(sensor_type: :personas).each do |beach_sensor|
      @current_people += beach_sensor.generate_people_and_send_data(ticks, @current_people, @beach_capacity)
    end
  end
end
