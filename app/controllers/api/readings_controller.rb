class Api::ReadingsController < ApiController

  before_action :set_instance, only: [:create]

  # POST /api/readings
  def create
    instance = Reading.create(reading_params)

    if instance.persisted?
      render json: { messages: ['Reading stored'], actions: [] }
    else
      render json: { messages: instance.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_instance
    @instance ||= Instance.find_by!(ip: request.remote_ip)
  rescue Mongoid::Errors::DocumentNotFound
    render json: { messages: ['Instance not registered'] }, status: :not_found
  end

  def reading_params
    params.require(:reading).permit!.merge(instance: @instance)
  end

end