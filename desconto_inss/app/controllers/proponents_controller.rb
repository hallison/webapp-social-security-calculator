class ProponentsController < ApplicationController
  before_action :load_proponent, only: %i[ show edit update destroy update_salary_net ]

  def index
    requested_page = params[:page] || 1
    @proponents = Proponent.order(:name).page requested_page
  end

  def new
    @proponent = Proponent.new
  end

  def create
    @proponent = Proponent.new proponent_params

    if @proponent.save
      redirect_to @proponent, notice: "Proponente criado com sucesso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @proponent.update proponent_params
      redirect_to @proponent, notice: "Proponente atualizado com sucesso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @proponent.destroy!

    redirect_to proponents_url(page: params[:page]), status: :see_other, notice: "Proponente foi excluído com sucesso"
  end

  def update_salary_net
    CalculateSocialContributionJob.perform_async @proponent.id

    status_params = {
      status: :see_other,
      notice: "Salário do proponente será calculado, aguarde alguns instantes",
    }
    if params[:page]
      redirect_to proponents_url(page: params[:page]), status_params
    else
      redirect_to @proponent, status_params
    end
  end

  def report
    @total_proponents = Proponent.count
    @contribution_ranges = Proponent::CONTRIBUTION_RANGES.each_with_object Hash.new do |(aliquot, range), data|
      key = "%0.2f" % (aliquot * 100).truncate(2)
      data[key] = {
        range: format("De %0.2f até %0.2f", range.first, range.last),
        total: Proponent.where(salary_social_contribution_aliquot: aliquot).count,
      }
    end

    @contribution_ranges.each do |aliquot, data|
      data.update percentual: "%0.2f" % (data[:total].to_f / @total_proponents * 100.0).truncate(2)
    end
  end

  private

  def proponent_params
    permitted_fields = %i[
      name
      document_br_cpf
      birth_date
      address_public_place
      address_number
      address_district
      address_city
      address_state
      address_postalcode
      phone_contact
      phone_reference
      salary_gross
    ]
    params.require(:proponent).permit permitted_fields
  end

  def load_proponent
    @proponent = Proponent.find proponent_id
  end

  def proponent_id
    params.require(:id)
  end
end
