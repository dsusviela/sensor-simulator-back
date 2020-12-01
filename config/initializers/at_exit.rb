at_exit do
  begin
    puts "Deleting all processes..."
    SimulatorProcess.delete_all
    puts "Processes deleted"
  rescue => e
    puts "There was an #{e.to_s} while flushing processes..."
  end
end
