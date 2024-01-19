module RepoUsers
  #
  # Clase abstracta para la generalización de atributos y comportamientos en usuarios
  #
  class User
    attr_reader :id_repo, :avatar, :login, :url, :repo_name, :params

    def validate_data
      raise 'must be implemented by concrete class'
    end
  end
end
