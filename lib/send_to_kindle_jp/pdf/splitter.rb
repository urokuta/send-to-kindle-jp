require 'pdf/reader'
require 'docsplit'
require 'shellwords'
require 'logger'
module SendToKindleJp
  module Pdf
    class Splitter
      class << self
        def split(directory)
          directory = directory.gsub(/\/$/, "")
          all_files = Dir.glob(directory + "/*.pdf")
          limit_mb = 50

          original_dir = "#{directory}/original"
          FileUtils.mkdir_p(original_dir) unless File.exist?(original_dir)

          all_files.each do |file|
            size = File.size(file)
            next if size < 49*1000000
            split_pdf(file, out_directory: directory)
            FileUtils.mv(file, original_dir)
          end
        end


        def split_pdf(file, out_directory:, limit_mb: 42)
          logger = Logger.new(STDOUT)
          limit = limit_mb*1000000
          size = File.size(file)
          num_pages = PDF::Reader.new(file).page_count

          size_per_page = size / num_pages.to_f

          per_page = (limit / size_per_page.to_f).ceil
          split_num = (num_pages / per_page.to_f).ceil
          # if you want to be splitted by same size, enable it.
          # split_num = (size / limit.to_f).ceil
          # per_page = num_pages / split_num


          in_file = file.shellescape
          ext = File.extname(file)
          out_base = File.basename(file, ext)
          split_num.times.each do |i|
            page_num = i+1
            _out_file = out_base + "-#{page_num}" + ".pdf"
            out_file = _out_file.shellescape
            f = (i*per_page + 1)
            is_end = split_num == page_num
            e = is_end ? "end" : ((i+1)*per_page)
            range = "#{f}-#{e}"
            out_directory = out_directory.shellescape
            cmd = "pdftk #{in_file} cat #{range} output #{out_directory}/#{out_file}"
            logger.info cmd
            result = system(cmd)
          end
        end
      end
    end
  end
end
