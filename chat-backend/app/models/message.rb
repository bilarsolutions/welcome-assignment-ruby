class Message < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  delegate :name, to: :user
end
