class ConvertAndMarkImageJob < ApplicationJob
  queue_as :default

  def perform(params)
    scanning = params[:scanning]
    scanning.update process_status: :processing_image
    ImageMarkerService.new(params).call
    scanning.update process_status: :image_marked
  end
end
