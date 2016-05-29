FactoryGirl.define do
  factory :reading_data do
    disk_usage    { rand * 100 }
    cpu_usage     { rand * 100 }
    process_list  { %W[process-#{rand(1..100)}]*10 }

    reading

    # after_build
  end
end