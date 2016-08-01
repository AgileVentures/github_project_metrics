require 'octokit'

class ProjectMetricGithub
  def initialize credentials = {}, raw_data = nil
    @identifier = URI::parse(credentials[:url]).path[1..-1]
    @client = Octokit::Client.new(access_token: ENV['GITHUB_KEY'])
  end

  def image
    %Q{<svg><rect x="0" y="0" width="#{score}" height="20" style="fill:yellow;stroke:black"/></svg>}
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