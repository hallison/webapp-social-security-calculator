# encoding: utf-8

class Proponent < ApplicationRecord
  include ::SocialSecurity

  validates :name, presence: true
  validates :document_br_cpf, presence: true, length: { is: 11 }
  validates :birth_date, presence: true
  validates :salary_gross, presence: true

  def social_contribution
    total_contribution salary
  end

  def update_salary_net!
    update_salary_net.save!
  end

  def update_salary_net
    self[:salary_net] = (salary - social_contribution) * 100 # Money
    self
  end

  private

  def salary
    salary_gross / 100.0 # Money
  end
end
