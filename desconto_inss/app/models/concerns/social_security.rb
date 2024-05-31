# encoding: utf-8

require "active_support/concern"

module SocialSecurity
  extend ActiveSupport::Concern

  included do
    DECIMALS = 2.freeze
    # 2020
    CONTRIBUTION_CEILINGS = {
      0.075 => 1_045.00,
      0.090 => 2_089.60,
      0.120 => 3_134.40,
      0.140 => 6_101.06,
    }
    # 2023
    # CONTRIBUTION_CEILINGS = {
    #   0.075 => 1_302.00,
    #   0.090 => 2_571.29,
    #   0.120 => 3_856.94,
    #   0.140 => 7_507.49,
    # }
    # 2024
    # CONTRIBUTION_CEILINGS = {
    #   0.075 => 1_412.00,
    #   0.090 => 2_666.68,
    #   0.120 => 4_000.03,
    #   0.140 => 7_786.02,
    # }

    def aliquot_contribution(salary_gross)
      total = total_contribution salary_gross
      (total / salary_gross * 100).truncate DECIMALS
    end

    def total_contribution(salary_gross)
      calculate_contributions(salary_gross).reduce(:+).truncate DECIMALS
    end

    def calculate_contributions(salary_gross)
      salary_base = salary_gross
      start_range = 0.0
      contributions = CONTRIBUTION_CEILINGS.map do |(aliquot, ceiling)|
        salary_gross_into_range = salary_gross.between? salary_base, ceiling
        salary_base = ((salary_gross_into_range ? salary_gross : ceiling) - start_range).truncate DECIMALS
        start_range = ceiling
        contribution = salary_base * aliquot
        contribution.truncate(DECIMALS) if contribution.positive?
      end.compact
    end
  end
end
