require "test_helper"

class ProponentTest < ActiveSupport::TestCase
  setup do
    @proponent = proponents(:one)
    @salaries = {
      101000 => { salary_social_contribution_aliquot: 0.075, salary_social_contribution_value: 7575 },
      201000 => { salary_social_contribution_aliquot: 0.09, salary_social_contribution_value: 15972 },
      301000 => { salary_social_contribution_aliquot: 0.12, salary_social_contribution_value: 26001 },
      401000 => { salary_social_contribution_aliquot: 0.14, salary_social_contribution_value: 38021 },
    }
  end

  test "should calculate social contribution" do
    @salaries.each do |salary, contributions|
      @proponent.salary_gross = salary

      @proponent.update_salary_net

      contributions.each do |attribute, value|
        assert_equal @proponent[attribute], value
      end
    end
  end
end
