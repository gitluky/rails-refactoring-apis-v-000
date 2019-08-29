class GithubRepo
  attr_accessor :name, :url

  def initialize(attrs)
      attrs.each do |k,v|
        k == 'html_url' ? self.send("url=", v) : self.send("#{k}=", v)
      end
  end


end
