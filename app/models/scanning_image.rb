class ScanningImage < ApplicationRecord
  belongs_to :scanning
  after_create_commit :extract_nucleus_job
  has_one_attached :original
  has_one_attached :png_image
  has_one_attached :marked_image
  has_many :scanned_cells
  accepts_nested_attributes_for :scanned_cells, allow_destroy: true
  before_validation :set_process_status
  after_update :check_if_all_imgaes_are_complete
  enum process_status: {
    waiting_start: 1,
    marking_image: 2,
    extracting_nucleus: 3,
    complete: 4
  }
  before_validation :set_analysis_status
  enum analysis_status: {
    pending: 0,
    analyzed: 1
  }


  private

    def set_process_status
      self.process_status = :waiting_start unless self.process_status
    end

    def extract_nucleus_job
      ExtractNucleusJob.perform_later(self)
    end

    def check_if_all_imgaes_are_complete
      scanning = self.scanning
      scanning.update(process_status: :complete) unless scanning.scanning_images.size > scanning.scanning_images.complete.size
    end

    def set_analysis_status
      self.analysis_status = :pending unless self.analysis_status
    end

end
