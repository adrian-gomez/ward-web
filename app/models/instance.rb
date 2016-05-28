class Instance
  include Mongoid::Document

  field :label, type: String
  field :ip, type: String

  has_many :readings

  validates :ip, presence: true
  validates :ip, uniqueness: true, allow_nil: true

  validate :valid_ip

  private

  def valid_ip
    IPAddress.parse(self.ip)
  rescue ArgumentError
    self.errors.add(:ip, 'is invalid')
  end

end