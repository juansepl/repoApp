require 'test_helper'
require 'myapi_helper'
class UsersTest < ActiveSupport::TestCase
  include MyapiHelper

  # Test data method
  test 'data fetches and caches user data' do
    users = Users.new('hawaii')
    stub_request(:get, "https://api.github.com/search/users?q=#{users.repo_name}").
      to_return(body: correct_api_answer)

    data = users.data

    assert_equal 2, data.size
    assert data[1000].is_a? RepoUsers::User
    assert data[1000].is_a? RepoUsers::Github

    # Ensure data is cached
    assert_equal data.object_id, users.data.object_id
  end

  context 'validate updating records from API' do
    should 'Do not update repository by invalid data from API' do
      repository = repositories(:one)
      repository.id_repo = 1000
      users = Users.new('hawaii')
      users.stub :by_id_repo, RepoUsers::Github.new(avatar: 'avatar', login: 'user1', url: 'url') do
        repository_to_update = users.update_by_repo(repository)
        assert !repository_to_update.valid?
      end
    end

    should "update_by_repo updates a repository with user data" do
      repository = repositories(:one)
      repository.id_repo = 1000
      users = Users.new('hawaii')
      avatar_expected = 'http://www.avatar.com'
      login_expected = 'user1'
      url_expected = 'http://www.urlactive.com'
      params_repo = {id: 1000, avatar_url: avatar_expected, login: login_expected, url: url_expected}.as_json
      users.stub :by_id_repo, RepoUsers::Github.new(params_repo) do
        users.update_by_repo(repository)
        repository.reload

        assert_equal avatar_expected, repository.avatar
        assert_equal login_expected, repository.login
        assert_equal url_expected, repository.url
      end

    end
  end
end