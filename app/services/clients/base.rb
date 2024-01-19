module Clients
  #
  # Clase abstracta para la concepción de clientes API
  #
  class Base
    include HTTParty

    #
    # Define la configuración de opciones a usar por el cliente API
    #
    # @return [Hash]
    #
    attr_reader :options

    def initialize
      @options = {
        format: :json
      }
    end

    #
    # Realiza la búsqueda en el recurso entregado
    #
    # @params [String] resource entrega el nombre del recurso para buscar
    # @params [String] name nombre del criterio a buscar
    #
    # @return [JSON]
    #
    def search(resource, name)
      raise ArgumentError if resource.blank? || name.blank?

      @options[:query] = { q: name }
      body = self.class.get(resource, @options).body

      JSON.parse(body)
    end

    #
    # Realiza la búsqueda de usuarios por el nombre del sitio
    #
    # @params [String] resource entrega el nombre del recurso para buscar
    # @params [String] name nombre del sitio o repositorio
    #
    # @return [JSON]
    #
    def users_by_repo(resource, name)
      search(resource, name)
    end
  end
end
