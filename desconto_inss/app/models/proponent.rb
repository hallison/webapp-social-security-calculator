# encoding: utf-8

class Proponent < ApplicationRecord
  include ::SocialSecurity

  validates :name, presence: true
  validates :document_br_cpf, presence: true, length: { is: 11 }
  validates :birth_date, presence: true
  validates :salary_gross, presence: true
end
