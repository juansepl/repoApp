class RepositoriesController < ApplicationController
  before_action :set_repository, only: %i[show edit update destroy]

  # GET /repositories or /repositories.json
  def index
    @repositories = Repository.order(:id_repo).page params[:page]
  end

  # GET /repositories/1 or /repositories/1.json
  def show; end

  # GET /repositories/new
  def new
    @repository = Repository.new
  end

  # GET /repositories/1/edit
  def edit; end

  # POST /repositories or /repositories.json
  def create
    @repository = Repository.new(repository_params)

    respond_to do |format|
      if @repository.save
        format.html { redirect_to repository_url(@repository), notice: 'Repository was successfully created.' }
        format.json { render :show, status: :created, location: @repository }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repositories/1 or /repositories/1.json
  def update
    respond_to do |format|
      if @repository.update(repository_params)
        format.html { redirect_to repository_url(@repository), notice: 'Repository was successfully updated.' }
        format.json { render :show, status: :ok, location: @repository }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repositories/1 or /repositories/1.json
  def destroy
    @repository.destroy

    respond_to do |format|
      format.html { redirect_to repositories_url, notice: 'Repository was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH /repositories/1
  def update_from_api
    @repository = Repository.find(params[:id])
    @repository.id_repo = repository_params['id_repo']

    respond_to do |format|
      @repository.update_by_repo

      if @repository.errors.blank?
        format.html { redirect_to repository_path(@repository), notice: 'Repository was sinchronized successfully.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_repository
    @repository = Repository.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def repository_params
    params.require(:repository).permit(:id_repo, :login, :avatar, :url)
  end
end
