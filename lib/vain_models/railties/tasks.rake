
desc "Vainly print out your model information"
task :vain_models do
    puts "TODO..."
    manifest = VainModels::Manifest.new
    puts manifest.models.inspect
end