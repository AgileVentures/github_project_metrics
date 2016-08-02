require 'octokit'
require 'erb'

class ProjectMetricGithub
  def initialize credentials = {}, raw_data = nil
    @url = credentials[:url]
    @identifier = URI::parse(@url).path[1..-1]
    @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    @client.auto_paginate = true # original projectscope had this - do we need?
  end

  def image
    @score = score
    # TODO next up adjust layout to display all the colors
    ERB.new(File.read('./lib/svg.erb')).result(get_binding)
  end

  def score
    @raw_data ||= get_pull_requests
    @red = @raw_data.items.count { |i| i.comments == 0 }
    @yellow = @raw_data.items.count { |i| i.comments == 1 }
    @green = @raw_data.items.count { |i| i.comments >= 2 }
    (@green + @yellow * 0.5) / (@green + @red + @yellow)
  end

  def raw_data=(raw_data)
    @raw_data = raw_data
  end

  def refresh
    @raw_data = get_pull_requests
    true
  end

  def get_binding
    binding
  end

  private

  def get_pull_requests
    @client.search_issues("repo:#{@identifier} type:pr")
  end
end