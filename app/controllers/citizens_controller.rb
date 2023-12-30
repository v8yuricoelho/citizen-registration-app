# frozen_string_literal: true

class CitizensController < ApplicationController
  def index
    @citizens = Citizen.all

    render json: @citizens, status: 200
  end

  def create
    @citizen = Citizen.new(citizen_params)

    if @citizen.save
      CitizenMailer.registration_notification(citizen_params[:full_name],
                                              citizen_params[:email]).deliver_later
      render json: @citizen, status: 200
    else
      render json: { errors: @citizen.errors.full_messages }, status: 400
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

  private

  def citizen_params
    params.permit(:full_name, :cpf, :cns, :email, :phone, :birthdate, :status, :address_id,
                  :picture)
  end
end
