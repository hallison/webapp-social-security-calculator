# encoding: utf-8

class Proponent < ApplicationRecord
  include SocialSecurityContribution

  validates :name, presence: true
  validates :document_br_cpf, presence: true, length: { is: 11 }
  validates :birth_date, presence: true
  validates :salary_gross, presence: true

  def update_salary_net!
    update_salary_net.save!
  end

  def update_salary_net
    calculate_total_contribution salary
    update_salary_social_contribution_value
    update_salary_social_contribution_range

    self[:salary_net] = (salary - social_contribution_value) * 100 # Money
    self
  end

  def update_salary_social_contribution_value
    self[:salary_social_contribution_value] = contribution[:total] * 100
    self
  end

  def update_salary_social_contribution_range
    self[:salary_social_contribution_range] = contribution[:aliquot_range]
    self
  end

  private

  def salary
    self[:salary_gross] / 100.0 # Money
  end

  def social_contribution_value
    self[:salary_social_contribution_value] / 100.0 # Money
  end

  def contribution
    @contribution || calculate_total_contribution(salary)
  end

  def calculate_total_contribution(salary)
    @contribution = total_contribution(salary)
  end
end
