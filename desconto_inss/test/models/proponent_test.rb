require "test_helper"

class ProponentTest < ActiveSupport::TestCase
  setup do
    @proponent = proponents(:one)
    @proponent.salary_gross = 300000
    @social_contribution = 28162
    @salary_net = 271838
  end

  test "should calculate social contribution" do
    @proponent.update_salary_social_contribution

    assert_equal @proponent.salary_social_contribution, @social_contribution
  end

  test "should calculate salary net" do
    @proponent.update_salary_net

    assert_equal @proponent.salary_net, @salary_net
  end
end
