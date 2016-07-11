class StaticPagesController < ApplicationController
  include PdfHelper

  def about
  end

  def contact_us
  end

  def references
  end

  def download_pdf
    send_file(
      "#{Rails.root}/public/Referências.pdf",
      filename: "Referências.pdf",
      type: "application/pdf"
    )
  end
end
