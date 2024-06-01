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
    update_salary_social_contribution
    self[:salary_net] = (salary - social_contribution) * 100 # Money
    self
  end

  def update_salary_social_contribution
    self[:salary_social_contribution] = total_contribution(salary) * 100
    self
  end

  private

  def salary
    self[:salary_gross] / 100.0 # Money
  end

  def social_contribution
    self[:salary_social_contribution] / 100.0 # Money
  end
end
