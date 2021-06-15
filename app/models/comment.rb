class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :nft
  has_one :notification
  validates :content, presence: true
  after_create :create_notification

  private

  def create_notification
    Notification.create(user: nft.user, comment: self)
  end
end
