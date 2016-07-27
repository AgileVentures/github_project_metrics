require 'project_metric_github'

describe ProjectMetricGithub do 
  context 'AgileVentures/WebsiteOne repo' do
    subject(:github_project_metrics) { described_class.new 'http://github.com/AgileVentures/WebsiteOne'}

    it 'has the corresponding scalar value' do
      expect(github_project_metrics.scalar).to eq 940
    end
  end
  context 'AgileVentures/LocalSupport repo' do
    subject(:github_project_metrics) { described_class.new 'http://github.com/AgileVentures/LocalSupport'}

    it 'has the corresponding scalar value' do
      expect(github_project_metrics.scalar).to eq 315
    end
  end
end