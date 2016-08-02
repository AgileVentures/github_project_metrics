require 'project_metric_github'

describe ProjectMetricGithub, :vcr  do 

  let(:raw_data) { JSON.parse(File.read('./spec/data/github_search_issues_ls_repo_type_pr_314.json'), object_class: OpenStruct) }
  let(:svg_wso_66_11) { File.read './spec/data/websiteone_66_11_pulls.svg' }
  let(:svg_ls_27_18) { File.read './spec/data/localsupport_27_18_pulls.svg' }
  let(:svg_ls_30_46) { File.read './spec/data/localsupport_30_46_pulls.svg' }

  context 'AgileVentures/WebsiteOne repo' do
    subject(:github_project_metrics) do
      described_class.new url: 'https://github.com/AgileVentures/WebsiteOne'
    end

    it 'has the corresponding score value' do
      expect(github_project_metrics.score).to eq 0.2803191489361702
    end

    it 'has the corresponding image value' do
      expect(github_project_metrics.image).to eq svg_wso_66_11
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
      expect(github_project_metrics.image).to eq svg_ls_27_18
    end

    it 'can have raw data set directly, avoiding network request', vcr: false do
      github_project_metrics.raw_data = raw_data
      expect(github_project_metrics.score).to eq 0.6166666666666667
      expect(github_project_metrics.image).to eq svg_ls_30_46
    end

    it 'can have network data refreshed, forcing network request' do
      github_project_metrics.raw_data = raw_data
      github_project_metrics.refresh
      expect(github_project_metrics.score).to eq 0.6328125
      expect(github_project_metrics.image).to eq svg_ls_27_18
    end

  end
end