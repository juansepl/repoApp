#
# Model Repository
#
class Repository < ApplicationRecord
  # attr_reader :repo_name

  paginates_per 6

  # Validations

  validates :login, presence: true
  # Control for fields with format URL
  validates :avatar, :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }

  def update_by_repo
    # repo_name = 'hawaii'
    users = Users.new(repo_name)
    users.update_by_repo(self)
  end

  def repo_name
    'hawaii'
  end
end
