# encoding: utf-8

require "active_support/concern"

module SocialSecurity
  extend ActiveSupport::Concern

  included do
    DECIMALS = 2.freeze
    CONTRIBUTION_PERIOD = "2024-01-01"
    CONTRIBUTION_CEILINGS = {
      "2020-01-01..2020-12-31" => {
        0.075 => 1_045.00,
        0.090 => 2_089.60,
        0.120 => 3_134.40,
        0.140 => 6_101.06,
      },
      "2023-01-01..2023-04-30" => {
        0.075 => 1_302.00,
        0.090 => 2_571.29,
        0.120 => 3_856.94,
        0.140 => 7_507.49,
      },
      "2023-05-01..2023-12-31" => {
        0.075 => 1_320.00,
        0.090 => 2_571.29,
        0.120 => 3_856.94,
        0.140 => 7_507.49,
      },
      "2024-01-01" => {
        0.075 => 1_412.00,
        0.090 => 2_666.68,
        0.120 => 4_000.03,
        0.140 => 7_786.02,
      }
    }.freeze

    CONTRIBUTION_RANGES = Hash.new.tap do |ranges|
      start_range = CONTRIBUTION_CEILINGS[CONTRIBUTION_PERIOD].first[1]
      ranges[CONTRIBUTION_CEILINGS[CONTRIBUTION_PERIOD].first[0]] = 0.0..start_range

      CONTRIBUTION_CEILINGS[CONTRIBUTION_PERIOD].to_a[1..-1].each_with_index.map do |(aliquot, ceiling), i|
        start_range += 0.01
        ranges[aliquot] = start_range.truncate(2)..ceiling
        start_range = ceiling
      end
    end.freeze

    def aliquot_contribution(salary_gross)
      total = total_contribution salary_gross
      (total / salary_gross * 100).truncate DECIMALS
    end

    def total_contribution(salary_gross)
      calculate_contributions(salary_gross).tap do |contribution|
        contribution.update total: contribution[:values].reduce(:+).truncate(DECIMALS)
      end
    end

    def calculate_contributions(salary_gross)
      salary_base = salary_gross
      start_range = 0.0
      aliquot_range = CONTRIBUTION_CEILINGS[CONTRIBUTION_PERIOD].keys.first
      contributions = CONTRIBUTION_CEILINGS[CONTRIBUTION_PERIOD].map do |(aliquot, ceiling)|
        salary_gross_into_range = salary_gross.between? salary_base, ceiling
        salary_base = ((salary_gross_into_range ? salary_gross : ceiling) - start_range).truncate DECIMALS
        start_range = ceiling
        contribution = salary_base * aliquot

        if contribution.positive?
          aliquot_range = aliquot
          contribution.truncate(DECIMALS)
        end
      end

      { aliquot_range: , values: contributions.compact }
    end
  end
end
