module Clients
  #
  # This class works with the github api
  #
  class Github < Clients::Base
    #
    # Define la URL base para Github
    #
    # @return [String]
    #
    base_uri 'https://api.github.com'

    #
    # Realiza la búsqueda de usuarios por el nombre del sitio
    #
    # @params [String] repo_name nombre del sitio o repositorio
    #
    # @return [Array<Hash>] ej:
    # [{
    #   "login": "hyperrex",
    #   "id": 13028451,
    #   "node_id": "MDQ6VXNlcjEzMDI4NDUx",
    #   "avatar_url": "https://avatars.githubusercontent.com/u/13028451?v=4",
    #   "gravatar_id": "",
    #   "url": "https://api.github.com/users/hyperrex",
    #   "html_url": "https://github.com/hyperrex",
    #   "followers_url": "https://api.github.com/users/hyperrex/followers",
    #   "following_url": "https://api.github.com/users/hyperrex/following{/other_user}",
    #   "gists_url": "https://api.github.com/users/hyperrex/gists{/gist_id}",
    #   "starred_url": "https://api.github.com/users/hyperrex/starred{/owner}{/repo}",
    #   "subscriptions_url": "https://api.github.com/users/hyperrex/subscriptions",
    #   "organizations_url": "https://api.github.com/users/hyperrex/orgs",
    #   "repos_url": "https://api.github.com/users/hyperrex/repos",
    #   "events_url": "https://api.github.com/users/hyperrex/events{/privacy}",
    #   "received_events_url": "https://api.github.com/users/hyperrex/received_events",
    #   "type": "User",
    #   "site_admin": false,
    #   "score": 1.0
    # }]
    #
    def users_by_repo(repo_name)
      body = super('/search/users', repo_name)
      body['items'].map do |item|
        RepoUsers::Github.new(item)
      end
    end
  end
end
