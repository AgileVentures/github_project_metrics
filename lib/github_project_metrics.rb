require 'httparty'

class GithubProjectMetrics
  def initialize identifier
    @identifier = identifier
  end

  def image
    # some visual representation of github activity
  end

  def scalar
    # some scalar representation of github activity
  end
end