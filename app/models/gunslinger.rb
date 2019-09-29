require 'credly_badge_service'

class Gunslinger < ApplicationRecord
  has_many :badges

  validates :first_name, :last_name, :email, presence: true

  def issued_badges
    CredlyBadgeService::get_badge(gunslinger: self)
  end
  
end
