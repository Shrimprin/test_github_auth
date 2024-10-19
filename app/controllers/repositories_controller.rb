# frozen_string_literal: true

class RepositoriesController < ApplicationController
  before_action :set_repository, only: %i[show edit update destroy]

  def index
    @repositories = Repository.all
  end

  def show; end

  def new
    @repository = Repository.new
  end

  def edit; end

  def create
    client = Octokit::Client.new(access_token: current_user.access_token)
    url = repository_params[:url] # 正規表現とかでチェックする必要はありそう
    repository_path = URI(url).path[1..] # /user/repository
    repository_info = client.repository(repository_path)
    repository_name = repository_info.name

    @repository = Repository.new(user: current_user, name: repository_name, path: repository_path)

    respond_to do |format|
      if @repository.save_with_file_items(client)
        format.html { redirect_to @repository, notice: 'Repository was successfully created.' }
        format.json { render :show, status: :created, location: @repository }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @repository.update(repository_params)
        format.html { redirect_to @repository, notice: 'Repository was successfully updated.' }
        format.json { render :show, status: :ok, location: @repository }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @repository.destroy!

    respond_to do |format|
      format.html { redirect_to repositories_path, status: :see_other, notice: 'Repository was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_repository
    @repository = Repository.find(params[:id])
  end

  def repository_params
    params.require(:repository).permit(:url)
  end
end
