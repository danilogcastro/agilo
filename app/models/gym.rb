class Gym < ApplicationRecord
  has_many :visits
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, :address, :latitude, :longitude, presence: true
  validates :address, uniqueness: true
  validates :latitude, uniqueness: { scope: :longitude, message: "There is already a gym with these coordinates"}

  before_validation :geocode_address, if: :address_changed?

  private

  def geocode_address
    return if address.blank?

    coordinates = Mapbox::Geocoder.call(address:)
    return if coordinates.blank?

    self.latitude = coordinates[:latitude]
    self.longitude = coordinates[:longitude]
  end
end
