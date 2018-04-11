class Party < ActiveRecord::Base

  # options = [:name, :description, :location]
  #
  # options.each do |required_info|
  #   validates required_info, presence: true
  # end

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true

  has_many :friends, through: :invited_friends
end
