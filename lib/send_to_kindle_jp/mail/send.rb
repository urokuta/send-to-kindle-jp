require 'mail'
module SendToKindleJp
  module Mail
    class Send
      class << self
        def send_to_kindle(to_address, directory)
          logger = Logger.new(STDOUT)

          all_files = Dir.glob(directory + "/*.pdf")
          all_files.each do |file|
            logger.info "send mail started. file: #{file}"
            send_mail(file)
            logger.info "send mail completed. file: #{file}"
            sleep(60)
            logger.info "sleep(60)"
            sleep(60)
            logger.info "sleep(60)"
            sleep(60)
            logger.info "sleep(60)"
            sleep(60)
            logger.info "sleep(60)"
          end
        end

        def send_mail(file)
          from = "test@gmx.com"
          mail = ::Mail.new do
            from    from
            to      "test@kindle.com"
            subject "test"
            body    "test dayo"
          end
          options = {
            address:        "mail.gmx.com",
            port:           587,
            domain:         "gmx.com",
            authentication: "plain",
            user_name:      "test@gmx.com",
            password:       "test",
            enable_starttls_auto: true,
            openssl_verify_mode: 'none',
          }
          mail.delivery_method(:smtp, options)
          mail.add_file(filename: File.basename(file), content: File.binread(file))
          mail.deliver!
        end
      end
    end
  end
end
