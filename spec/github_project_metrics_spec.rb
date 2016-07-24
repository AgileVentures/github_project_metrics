require 'github_project_metrics'

describe GithubProjectMetrics do 
  context 'AgileVentures/WebsiteOne repo' do
    subject(:github_project_metrics) { described_class.new 'http://github.com/AgileVentures/WebsiteOne'}

    it 'has the corresponding scalar value' do
      expect(github_project_metrics.scalar).to eq 939
    end
  end
  context 'AgileVentures/LocalSupport repo' do
    subject(:github_project_metrics) { described_class.new 'http://github.com/AgileVentures/LocalSupport'}

    it 'has the corresponding scalar value' do
      expect(github_project_metrics.scalar).to eq 313
    end
  end
end