FactoryGirl.define do
  factory :reading do
    data { { disk_usage: rand * 100, cpu_usage: rand * 100,
             process_list: %W[process-#{rand(1..100)}]*10 } }

    instance
  end
end