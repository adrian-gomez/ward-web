class ReadingData
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  embedded_in :reading

end