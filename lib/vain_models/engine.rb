
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
	  attr_accessor :models
	  def initialize
	    find_models
	  end
	  
	  def model_dir
	    File.join(Rails.root, 'app', 'models')
	  end
    
    def find_models
      model_files = find_model_files
      @models = []
      model_files.each do |file|
        model = find_model_from_file(file)
        if model && model < ActiveRecord::Base
          @models << model 
        end
      end
    end
    
    def find_model_from_file(file)
      
      model_name = file.gsub(/\.rb$/, '').camelize
      model = nil
      parts = model_name.split('::')
      begin
        parts.inject(Object) do |klass, part| 
          model = klass.const_get(part) 
        end
      rescue LoadError, NameError
        begin
          model = Object.const_get(parts.last)
        rescue LoadError, NameError => e
        
        end
      end
      model
    end
	  
	  def find_model_files
      model_files = []
        Dir.chdir(model_dir) do
          model_files = Dir["**/*.rb"]
        end
      model_files
    end
  end
end