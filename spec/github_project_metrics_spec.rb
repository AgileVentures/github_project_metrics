require 'project_metric_github'

describe ProjectMetricGithub, :vcr  do 

  let(:raw_data) { JSON.parse File.read './spec/data/github_search_issues_ls_repo_type_pr_314.json' }
  let(:svg_output_940) { File.read './spec/data/output_940.svg' }
  let(:svg_output_315) { File.read './spec/data/output_315.svg' }
  let(:svg_output_314) { File.read './spec/data/output_314.svg' }

  context 'AgileVentures/WebsiteOne repo' do
    subject(:github_project_metrics) do
      described_class.new url: 'http://github.com/AgileVentures/WebsiteOne'
    end

    it 'has the corresponding score value' do
      expect(github_project_metrics.score).to eq 940
    end

    it 'has the corresponding image value' do
      expect(github_project_metrics.image).to eq svg_output_940
    end
  end

  context 'AgileVentures/LocalSupport repo' do
    subject(:github_project_metrics) do
      described_class.new url: 'http://github.com/AgileVentures/LocalSupport'
    end

    it 'has the corresponding score value' do
      expect(github_project_metrics.score).to eq 315
    end

    it 'has the corresponding image value' do
      expect(github_project_metrics.image).to eq svg_output_315
    end

    it 'can have raw data set directly, avoiding network request', vcr: false do
      github_project_metrics.raw_data = raw_data
      expect(github_project_metrics.score).to eq 314
      expect(github_project_metrics.image).to eq svg_output_314
    end

    it 'can have network data refreshed, forcing network request' do
      github_project_metrics.raw_data = raw_data
      github_project_metrics.refresh
      expect(github_project_metrics.score).to eq 315
      expect(github_project_metrics.image).to eq svg_output_315
    end

  end
end