class ReadingData
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :cpu_usage, type: Float
  field :disk_usage, type: Float

  embedded_in :reading

end