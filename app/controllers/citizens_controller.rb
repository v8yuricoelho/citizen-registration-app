# frozen_string_literal: true

class CitizensController < ApplicationController
  before_action :set_citizen, only: %i[show edit update]

  def index
    @citizens = Citizen.all.page params[:page]
  end

  def create
    @citizen = Citizen.new(citizen_params)

    if @citizen.save
      CitizenMailer.registration_notification(citizen_params[:full_name],
                                              citizen_params[:email]).deliver_later
      redirect_to @citizen
    else
      redirect_to new_citizen_path(@citizen)
    end
  end

  def update
    if @citizen.update(citizen_params)
      CitizenMailer.registration_notification(@citizen.full_name, @citizen.email).deliver_later
      redirect_to @citizen
    else
      redirect_to new_citizen_path(@citizen)
    end
  end

  def new
    @citizen = Citizen.new
    @citizen.build_address
  end

  def show; end

  def edit; end

  private

  def citizen_params
    params.require(:citizen).permit(:full_name, :cpf, :cns, :email, :phone,
                                    :birthdate, :status, :picture,
                                    address_attributes: %i[zip_code street unit
                                                           neighborhood city ibge_code uf])
  end

  def set_citizen
    @citizen = Citizen.find(params[:id])
  end
end
