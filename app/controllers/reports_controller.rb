class ReportsController < ApplicationController

  def index
    @cpu_usage_rank = cpu_usage_rank
    @low_disk_space = low_disk_usage
  end

  private

  def cpu_usage_rank
    Instance.all.map do |instance|
      reading = instance.readings.last

      next unless reading

      cpu_usage = reading.data.cpu_usage

      next unless cpu_usage

      [instance, cpu_usage]
    end.compact
       .sort_by { |_, cpu_usage| cpu_usage }
       .reverse
  end

  def low_disk_usage
    Instance.all.map do |instance|
      reading = instance.readings.last

      next unless reading

      disk_usage = reading.data.disk_usage

      next unless disk_usage

      [instance, disk_usage]
    end.compact
       .select { |_, disk_usage| disk_usage > 90 }
       .sort_by { |_, disk_usage| disk_usage }
  end

end