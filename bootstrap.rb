class Bootstrap
  class << self
    def reload
      dirs = ["lib"]
      dirs.each do |dir|
        Dir[File.expand_path("../#{dir}", __FILE__) << '/**/*.rb'].each do |file|
          load file
        end
      end
    end
  end
end
