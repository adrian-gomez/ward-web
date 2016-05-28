class Reading
  include Mongoid::Document

  field :type, type: String
  field :value, type: Float

  belongs_to :instance

  validates! :instance, presence: true
  validates :type, inclusion: { in: Enums::ReadingTypes::ALL }
  validates :value, presence: true

end