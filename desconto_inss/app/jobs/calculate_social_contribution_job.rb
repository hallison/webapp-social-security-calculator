class CalculateSocialContributionJob
  include Sidekiq::Worker

  # retry_on SocialSecurityContributionError, wait: 5.minutes, queue: :low_priority

  sidekiq_options queue: "default", retry: 5

  def perform(proponent_id)
    proponent = Proponent.find proponent_id
    proponent.update_salary_net!

    return true
  end
end
