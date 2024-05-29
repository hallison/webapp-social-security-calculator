class ProponentsController < ApplicationController
  def index
    requested_page = params[:page] || 1
    @proponents = Proponent.order(:name).page requested_page
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
