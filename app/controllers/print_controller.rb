class PrintController < ApplicationController
  skip_before_action :verify_authenticity_token

  def to_printer
    parameters = print_params

    print_command = "lpr -P CanonMF4800 -o fit-to-page -o media=A4 "
    if parameters[:duplex].present?
      print_command << "-o sides=two-sided-long-edge "
    end
    if parameters[:copies].present?
      print_command << "-##{parameters[:copies]} "
    end
    if parameters[:page].present?
      print_command << "-o page-ranges=#{parameters[:page]} "
    end

    print_command << parameters[:path]

    # logger.info "XXXXXXXX #{print_command}"
    `#{print_command}`
    redirect_to school_document_url(parameters[:id])




    # @document_path = "/Volumes/Data/WS/rails_project/as_dms/public/store/files/8402344c22412ef401198539bed23a5b22a3c8f9.pdf"
    # `lpr -o fit-to-page -o media=A4 #{@document_path}`
    # redirect_to
  end

  private

  def print_params
    params.require(:print).permit(:page, :copies, :duplex, :path, :id)
  end
end
