require 'test_helper'
require 'myapi_helper'
class Clients::GithubTest < ActiveSupport::TestCase
  include MyapiHelper

  test 'data fetches to users' do
    stub_request(:get, 'https://api.github.com/search/users?q=hawaii')
      .to_return(body: correct_api_answer)

    data = Clients::Github.new.users_by_repo('hawaii')

    assert_equal 2, data.size
    assert data.first.is_a? RepoUsers::User
    assert data.first.is_a? RepoUsers::Github
  end

  test 'data fetches to with empty fields' do
    stub_request(:get, 'https://api.github.com/search/users?q=hawaii')
      .to_return(body: bad_api_answer)

    data = Clients::Github.new.users_by_repo('hawaii')

    assert_equal 2, data.size
    assert data.first.is_a? RepoUsers::User
    assert data.first.is_a? RepoUsers::Github
  end
end
