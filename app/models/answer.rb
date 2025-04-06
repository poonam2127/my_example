class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :response_text, presence: true
  validates :proposed_fee, presence: true

  scope :paid, -> { where(paid: true) }
end
