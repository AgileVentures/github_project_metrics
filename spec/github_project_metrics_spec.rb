require 'project_metric_github'

describe ProjectMetricGithub do 
  context 'AgileVentures/WebsiteOne repo' do
    subject(:github_project_metrics) do
      described_class.new url: 'http://github.com/AgileVentures/WebsiteOne'
    end

    it 'has the corresponding scalar value' do
      expect(github_project_metrics.score).to eq 940
    end
  end
  context 'AgileVentures/LocalSupport repo' do
    subject(:github_project_metrics) do
      described_class.new url: 'http://github.com/AgileVentures/LocalSupport'
    end

    it 'has the corresponding scalar value' do
      expect(github_project_metrics.score).to eq 315
    end
  end
end