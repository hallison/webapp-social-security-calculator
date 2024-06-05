require "rails_helper"

RSpec.describe CalculateSocialContributionJob, type: :job do
  fixtures :all

  let(:proponent) { proponents(:one) }
  let(:results) do
    {
      salary_social_contribution_aliquot: 0.12,
      salary_social_contribution_value: 25881,
      salary_net: 274119,
    }
  end

  let(:job) { described_class.new }

  it "perform" do
    job.perform proponent.id

    proponent.reload

    results.each do |attribute, expected_value|
      expect(proponent[attribute]).to eq(expected_value)
    end
  end
end
