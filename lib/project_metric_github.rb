require 'octokit'

class ProjectMetricGithub
  def initialize credentials = {}, raw_data = nil
    @identifier = URI::parse(credentials[:url]).path[1..-1]
    @client = Octokit::Client.new(access_token: ENV['GITHUB_KEY'])
  end

  def image
    # some visual representation of github activity
  end

  def score
    @client.search_issues("repo:#{@identifier} type:pr")['total_count']
  end
end