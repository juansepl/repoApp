require 'test_helper'
require 'myapi_helper'
class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  include MyapiHelper

  setup do
    @repository = repositories(:one)
    WebMock.disable_net_connect! # Disable network connections to ensure your tests don't make real requests
  end

  def teardown
    WebMock.allow_net_connect! # Re-enable network connections after the test
  end

  test 'should get index' do
    get repositories_url
    assert_response :success
  end

  test 'should get new' do
    get new_repository_url
    assert_response :success
  end

  test 'should create repository' do
    assert_difference('Repository.count') do
      post repositories_url,
           params: { repository: { avatar: @repository.avatar, id_repo: @repository.id_repo, login: @repository.login,
                                   url: @repository.url } }
    end

    assert_redirected_to repository_url(Repository.last)
  end

  test 'should show repository' do
    get repository_url(@repository)
    assert_response :success
  end

  test 'should get edit' do
    get edit_repository_url(@repository)
    assert_response :success
  end

  test 'should update repository' do
    avatar_expected = 'http://www.new_avatar.com'
    url_expected = 'http://www.new_avatar.com'
    login_expected = 'new_login'
    id_repo_expected = 700

    patch repository_url(@repository),
          params: { repository: { avatar: avatar_expected, id_repo: id_repo_expected, login: login_expected,
                                  url: url_expected } }
    assert_redirected_to repository_url(@repository)
    @repository.reload
    assert_equal id_repo_expected, @repository.id_repo
    assert_equal avatar_expected, @repository.avatar
    assert_equal login_expected, @repository.login
    assert_equal url_expected, @repository.url
  end

  test 'should destroy repository' do
    assert_difference('Repository.count', -1) do
      delete repository_url(@repository)
    end

    assert_redirected_to repositories_url
  end

  context 'Avoiding update repositories' do
    should 'not update repository from api by not found the id_repo' do
      stub_request(:get, 'https://api.github.com/search/users?q=hawaii')
        .to_return(body: correct_api_answer, status: 200)

      patch update_from_api_repository_url(@repository),
            params: { repository: { id_repo: @repository.id_repo } }

      assert_response :unprocessable_entity

      users = Users.new(@repository.repo_name)
      assert users.data.present?
      assert_nil users.by_id_repo(@repository.id_repo)
    end

    should 'not update repository by emptry fields from api response' do
      stub_request(:get, 'https://api.github.com/search/users?q=hawaii')
        .to_return(body: bad_api_answer, status: 200)

      patch update_from_api_repository_url(@repository),
            params: { repository: { id_repo: 1000 } }

      assert_response :unprocessable_entity

      users = Users.new(@repository.repo_name)
      assert users.data.present?
      assert_nil users.by_id_repo(@repository.id_repo)
    end
  end

  test 'update repository from api  with match to the id_repo' do
    stub_request(:get, 'https://api.github.com/search/users?q=hawaii')
      .to_return(body: correct_api_answer, status: 200)

    @repository.id_repo = 1000
    patch update_from_api_repository_url(@repository),
          params: { repository: { id_repo: @repository.id_repo } }

    users = Users.new(@repository.repo_name)
    user_repo_expected = users.by_id_repo(@repository.id_repo)

    assert_redirected_to repository_url(@repository)
    @repository.reload

    assert_equal @repository.id_repo, user_repo_expected.id_repo
    assert_equal @repository.avatar, user_repo_expected.avatar
    assert_equal @repository.login, user_repo_expected.login
    assert_equal @repository.url, user_repo_expected.url
  end

  test 'api stub' do
    stub_request(:get, 'www.example.com')
      .to_return(body: 'success', status: 200)
  end

  test 'respuesta exitosa de api' do
    stub_request(:get, 'https://api.github.com/search/users?q=hawaii')
      .to_return(body: correct_api_answer, status: 200)

    puts Users.by_repo('hawaii')
  end
end
