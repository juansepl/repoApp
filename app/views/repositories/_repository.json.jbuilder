json.extract! repository, :id, :id_repo, :login, :avatar, :url, :created_at, :updated_at
json.url repository_url(repository, format: :json)
