FactoryGirl.define do
  factory :reading do
    type  Enums::ReadingTypes::DISK_USAGE
    value 1.1

    instance
  end
end