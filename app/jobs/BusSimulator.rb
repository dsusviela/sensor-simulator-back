class BusSimulator
  def call
    Rails.logger.info "Running Bus Simulator..."

    threads = []

    BusSensor.all do |bus_sensor|
      threads << Thread.new { bus_sensor.send_data() }
    end

    threads.each do |thread|
      thread.join
    end
  end
end
