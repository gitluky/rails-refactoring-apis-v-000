class GithubService

  attr_accessor :access_token

  def initialize(hash={})
    if hash.is_a?(Hash)
      hash.each do |k,v|
        self.send("#{k}=", v) unless hash.empty?
      end
    else
      @access_token = hash
    end
  end

  def authenticate!(client_id, client_secret, code)
    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: client_id, client_secret: client_secret, code: code}, {'Accept' => 'application/json'}
    body = JSON.parse(response.body)
    @access_token = body['access_token']
  end

  def get_username
    response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    body = JSON.parse(response.body)
    body['login']
  end

  def get_repos
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
    body = JSON.parse(response.body)
    body.map {|repo| GithubRepo.new(repo)}
  end

  def create_repo(name)
    response = Faraday.post "https://api.github.com/user/repos", {name: name}.to_json, {'Authorization' => "token #{@access_token}", 'Accept' => 'application/json'}
  end



end
