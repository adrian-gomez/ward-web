class Reading
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :instance
  embeds_one :data, class_name: 'ReadingData'

  validates! :instance, presence: true

  validates :data, presence: true

  def self.from_last_hours(hours = 12)
    self.where(:created_at.gte => (Time.now - hours.hours))
  end

  def as_json(*args)
    data = super

    data['created_at'] = self.created_at.utc.iso8601
    data['updated_at'] = self.updated_at.utc.iso8601

    data
  end

end