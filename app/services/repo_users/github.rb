module RepoUsers
  #
  # Clase concreta para los usuarios que provienen de github
  #
  class Github < RepoUsers::User
    def initialize(params)
      super()
      @repo_name = 'hawaii'
      @id_repo = params['id']
      @avatar = params['avatar_url']
      @login = params['login']
      @url = params['url']
    end
  end
end
