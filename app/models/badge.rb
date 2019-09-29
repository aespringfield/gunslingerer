require 'credly_badge_service'

class Badge < ApplicationRecord
  belongs_to :gunslinger
  validates :badge_template_id, presence: true

  after_save :post_to_credly

  def issued_at
    self.created_at
  end

  def post_to_credly
    CredlyBadgeService::post_badge(
      gunslinger: gunslinger,
      badge_template_id: badge_template_id
    )
  end
end
