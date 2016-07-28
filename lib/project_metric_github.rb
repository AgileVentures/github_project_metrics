require 'octokit'

class ProjectMetricGithub
  def initialize credentials = {}, raw_data = nil
    @identifier = URI::parse(credentials[:url]).path[1..-1]
    @client = Octokit::Client.new(access_token: ENV['GITHUB_KEY'])
  end

  # def initialize credentials = {}, raw_data = nil
  #   @identifier = "github#{URI::parse(credentials[:url]).path}"
  #   @raw_data = raw_data
  # end

  def image
    # some visual representation of github activity
  end

  def score
    @raw_data ||= get_pull_requests
    @raw_data['total_count']
  end

  def raw_data=(raw_data)
    @raw_data = raw_data
  end

  def refresh
    @raw_data = get_pull_requests
    true
  end

  private

  def get_pull_requests
    @client.search_issues("repo:#{@identifier} type:pr")
  end
end