require 'octokit'
require 'erb'

class ProjectMetricGithub

  attr_reader :raw_data

  def initialize credentials = {}, raw_data = nil
    @url = credentials[:url]
    @identifier = URI::parse(@url).path[1..-1]
    @raw_data = raw_data
    @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    @client.auto_paginate = true 
  end

  def image
    @score = score
    file_path = File.join(File.dirname(__FILE__),'svg.erb')
    ERB.new(File.read(file_path)).result(self.send(:binding))
  end

  def score
    @raw_data ||= get_pull_requests
    @total = @raw_data.items.count
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

  private

  def get_pull_requests
    @client.search_issues("repo:#{@identifier} type:pr")
  end
end