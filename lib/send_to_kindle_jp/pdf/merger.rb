require 'rmagick'
require 'logger'
module SendToKindleJp
  module Pdf
    class Merger
      class << self
        def merge(directory)
          logger = Logger.new(STDOUT)
          images = _image_files(directory)
          grouped = images.group_by{|path| path.split("/")[-2]}
          generateds = []
          grouped.each do |k,v|
            pdf_name = k
            generated = generate_pdf(pdf_name, directory, v)
            if ! generated
              logger.info "#{pdf_name} is already generated"
            end
            generateds << pdf_name
          end
          generateds
        end

        def _image_files(directory)
          directory = directory.gsub(/\/$/, "")
          all_files = Dir.glob(directory + "/**/*.{jpg,jpeg,png}")
        end

        def generate_pdf(name, dir, images)
          logger = Logger.new(STDOUT)
          file_name = "#{dir}/#{name}.pdf"
          return false if File.exist?(file_name)
          r = Magick::ImageList.new()
          logger.info "============================== merge started =============================="
          images.each do |image|
            logger.info image
            m_image = Magick::Image.read( image )[0]
            r << m_image
          end
          dir = dir.gsub(/\/$/, "")
          r.write(file_name)
          r.each do |i|
            i.destroy!
          end
          logger.info "============================== merge write completed =============================="
          true
        end
      end
    end
  end
end
