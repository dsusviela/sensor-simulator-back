class SimulatorProcess < ApplicationRecord
  before_create :schedule_job
  after_destroy :unschedule_job

  private
  def schedule_job
    unless job_id.present?
      simulator_class = is_beach ? BeachSimulator.new : BusSimulator.new
      self.job_id = rufus_singleton.every '5s', simulator_class
    end
  end

  def unschedule_job
    rufus_singleton.unschedule(job_id)
  end

  def rufus_singleton
    Rufus::Scheduler.singleton
  end
end
