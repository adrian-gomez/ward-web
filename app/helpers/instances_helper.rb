module InstancesHelper

  def instance_title(instance)
    if instance.label.present?
      "#{instance.label} [#{instance.ip}]"
    else
      "#{instance.ip}"
    end
  end

end