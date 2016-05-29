class Instances::ReadingsController < ApplicationController

  before_action :set_instance
  before_action :set_reading, only: [:show]

  # GET /instances/:instance_id/readings
  def index
    readings = @instance.readings.from_last_hours(2)

    render json: readings.to_json
  end

  # GET /instances/:instance_id/readings/:id
  def show
  end

  private

  def set_instance
    @instance ||= Instance.find(params[:instance_id])
  rescue Mongoid::Errors::DocumentNotFound
    render json: { messages: ['Instance not found'] }, status: :not_found
  end

  def set_reading
    @reading ||= @instance.readings.find(params[:id])
  rescue Mongoid::Errors::DocumentNotFound
    render json: { messages: ['Reading not found'] }, status: :not_found
  end

end