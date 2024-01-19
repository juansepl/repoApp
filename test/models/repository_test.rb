require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  setup do
    @repository = Repository.new(id_repo: 1, login: 'login', url: 'https://www.example.com', avatar: 'https://www.example2.com')
  end

  test 'valid URL should be accepted from fields avatar and url' do
    assert @repository.valid?, 'Expected website to be valid'
  end

  test 'invalid URL should not be accepted for field avatar and url' do
    @repository.update(url: 'httpexample', avatar: 'example2.com')

    assert_not @repository.valid?, 'Expected repository to be invalid'
    assert_includes @repository.errors[:url], 'is invalid'
    assert_includes @repository.errors[:avatar], 'is invalid'
  end
end
