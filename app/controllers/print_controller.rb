class PrintController < ApplicationController
  skip_before_action :verify_authenticity_token

  def to_printer
    parameters = print_params

    print_command = "lpr -o fit-to-page -o media=A4 "

    if parameters[:printer].present?
      print_command << "-P #{parameters[:printer]} "
    end

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

    logger.info "XXXXXXXX #{print_command}"
    `#{print_command}`
    redirect_to school_document_url(parameters[:id]), notice: "Document Printed"
  end

  private

  def print_params
    params.require(:print).permit(:page, :copies, :duplex, :path, :id, :printer)
  end
end
