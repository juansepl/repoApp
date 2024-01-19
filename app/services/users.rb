#
# Class gestionar usuarios y obtener datos desde el API
#
class Users
  #
  # Nombre del repositorio a buscar
  #
  # @return [String]
  #
  attr_reader :repo_name

  def initialize(repo_name)
    @repo_name = repo_name
  end

  #
  # Datos de usuarios ordenados con formato en tabla de hash por id del repositorio
  #
  # @return [Hash]
  # ej: {1000 => RepoUsers::User}
  #
  def data
    @data ||= begin
      repos = self.class.by_repo(repo_name)
      repos.index_by(&:id_repo)
    end
  end

  #
  # Lista de datos de usuarios
  #
  # @return [Array<RepoUsers::User>]
  # ej: [RepoUsers::User]
  #
  def self.by_repo(repo_name)
    client = Clients::Github.new
    client.users_by_repo(repo_name)
  end

  #
  # Actualiza el repositorio con el id_repo asignado
  #
  # @param [Repository<ActiveRecord>] repository registro de repositorio a actualizar
  #
  # @return [Repository<ActiveRecord>]
  #
  def update_by_repo(repository)
    repo = by_id_repo(repository.id_repo)

    if repo.nil?
      repository.errors.add(:base, "Repositorio no encontrado para el id_repo #{repository.id_repo}")
      return repository
    end

    params_to_update = { avatar: repo.avatar, login: repo.login, url: repo.url }
    repository.update(params_to_update)
    repository
  end

  #
  # Busca un usuario por medio del id del repositorio remoto
  #
  # @param [Integer] id_repo id del repositorio remoto del usuario
  #
  # @return [RepoUsers::User]
  #
  def by_id_repo(id_repo)
    data[id_repo]
  end
end
