# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'send_to_kindle_jp/version'

Gem::Specification.new do |spec|
  spec.name          = "send_to_kindle_jp"
  spec.version       = SendToKindleJp::VERSION
  spec.authors       = ["urokuta"]
  spec.email         = ["takuro.mizobe@gmail.com"]

  spec.summary       = %q{Automation for send-to-kindle in Japan. Split pdf under 50mb (send-to-kindle email limit) and email to your kindle account.}
  spec.description   = %q{If you want to automate, 1. Split pdf to under 50mb. 2. send these pdfs to your kindle email address, this gem is the one.}
  spec.homepage      = "https://github.com/urokuta/send_to_kindle_jp"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
#   if spec.respond_to?(:metadata)
#     spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
#   else
#     raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
#   end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "docsplit", "0.7.6"
  spec.add_development_dependency "rmagick", "~> 2.16.0"
  spec.add_development_dependency "pdf-reader", "~> 1.4.0"
  spec.add_development_dependency "mail", "~> 2.6.4"
  spec.add_development_dependency "pry"
end
