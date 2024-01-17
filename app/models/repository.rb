#
# Model Repository
#
class Repository < ApplicationRecord
  paginates_per 10

  # Validations

  validates :login, presence: true
  # Control for fields with format URL
  validates :avatar, :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
end
