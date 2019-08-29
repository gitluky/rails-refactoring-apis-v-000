class RepositoriesController < ApplicationController
  def index
    github = GithubService.new(session[:token])
    @repos_array = github.get_repos
    @username = github.get_username
  end

  def create
    github = GithubService.new(session[:token])
    github.create_repo(params[:name])
    redirect_to '/'
  end
end
