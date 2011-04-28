
module VainModels
	class Engine < Rails::Engine
		initializer "static assets" do |app|
		  app.middleware.use ::ActionDispatch::Static, "#{root}/public"
		end
	end
	
	class Manifest
	  attr_accessor :models
	  def initialize
	    find_models
	  end
	  
	  def model_dir
	    Dir.join(Rails.root, 'app', 'models')
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