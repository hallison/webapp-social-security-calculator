class UpdateProponentSalaryField < ActiveRecord::Migration[7.1]
  def change
    add_column :proponents, :salary_gross, :integer
    add_column :proponents, :salary_net, :integer, null: true

    Proponent.update_all "salary_gross = salary"

    remove_column :proponents, :salary, :integer
  end
end
