class ProponentsController < ApplicationController
  before_action :load_proponent, only: %i[ show edit update destroy ]

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
  end

  def destroy
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
