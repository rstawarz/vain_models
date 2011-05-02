
module VainModels
	class Engine < Rails::Engine
		initializer "static assets" do |app|
		  app.middleware.use ::ActionDispatch::Static, "#{root}/public"
		end
    
    rake_tasks do
      load 'vain_models/railties/tasks.rake'
    end
	end
	
	class Manifest
	  attr_accessor :models, :model_files
	  def initialize
	    find_models
	  end
	  
	  def model_dir
	    File.join(Rails.root, 'app', 'models')
	  end
    
    def find_models
      find_model_files
      @models = []
      @model_files.each do |file|
        model = file.gsub(/\.rb$/, '').camelize
        puts model
        parts = model.split('::')
        begin
          parts.inject(Object) {|klass, part| @models << klass.const_get(part) }
        rescue LoadError, NameError
          begin
            @models << Object.const_get(parts.last)
          rescue
          end
        end
      end
    end
	  
	  def find_model_files
      @model_files = []
        Dir.chdir(model_dir) do
          @model_files = Dir["**/*.rb"]
        end
      puts "model_files: #{@model_files.inspect}" 
      @model_files
    end
  end
end