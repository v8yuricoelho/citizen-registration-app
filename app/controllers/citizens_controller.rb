# frozen_string_literal: true

class CitizensController < ApplicationController
  before_action :set_citizen, only: %i[show]

  def index
    @citizens = Citizen.all.page params[:page]
  end

  def create
    @citizen = Citizen.new(citizen_params)

    respond_to do |format|
      if @citizen.save
        CitizenMailer.registration_notification(citizen_params[:full_name],
                                                citizen_params[:email]).deliver_later
        format.html { redirect_to @citizen, status: :ok }
      else
        render json: { errors: @citizen.errors.full_messages }, status: 400
      end
    end
  end

  def update
    @citizen = Citizen.find(params[:id])

    if @citizen.update(citizen_params)
      CitizenMailer.registration_notification(@citizen.full_name, @citizen.email).deliver_later
      render json: @citizen, status: 200
    else
      render json: { errors: @citizen.errors.full_messages }, status: 400
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
    params.permit(:full_name, :cpf, :cns, :email, :phone, :birthdate, :status, :picture,
                  address_attributes: %i[zip_code street unit neighborhood city ibge_code uf])
  end

  def set_citizen
    @citizen = Citizen.find(params[:id])
  end
end
