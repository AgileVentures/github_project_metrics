require 'project_metric_github'

describe ProjectMetricGithub, :vcr  do 

  let(:raw_data) { JSON.parse(File.read('./spec/data/github_search_issues_ls_repo_type_pr_314.json'), object_class: OpenStruct) }
  let(:svg_wso_two_point_five) { File.read './spec/data/websiteone_940_pulls.svg' }
  let(:svg_ls_six_point_one_six) { File.read './spec/data/localsupport_315_pulls.svg' }
  let(:svg_output_314) { File.read './spec/data/localsupport_314_pulls.svg' }

  context 'AgileVentures/WebsiteOne repo' do
    subject(:github_project_metrics) do
      described_class.new url: 'https://github.com/AgileVentures/WebsiteOne'
    end

    it 'has the corresponding score value' do
      expect(github_project_metrics.score).to eq 0.2803191489361702
    end

    it 'has the corresponding image value' do
      expect(github_project_metrics.image).to eq svg_wso_two_point_five
    end
  end

  context 'AgileVentures/LocalSupport repo' do
    subject(:github_project_metrics) do
      described_class.new url: 'https://github.com/AgileVentures/LocalSupport'
    end

    it 'has the corresponding score value' do
      expect(github_project_metrics.score).to eq 0.6328125
    end

    it 'has the corresponding image value' do
      expect(github_project_metrics.image).to eq svg_ls_six_point_one_six
    end

    it 'can have raw data set directly, avoiding network request', vcr: false do
      github_project_metrics.raw_data = raw_data
      expect(github_project_metrics.score).to eq 0.6166666666666667
      expect(github_project_metrics.image).to eq svg_output_314
    end

    it 'can have network data refreshed, forcing network request' do
      github_project_metrics.raw_data = raw_data
      github_project_metrics.refresh
      expect(github_project_metrics.score).to eq 0.6328125
      expect(github_project_metrics.image).to eq svg_ls_six_point_one_six
    end

  end
end