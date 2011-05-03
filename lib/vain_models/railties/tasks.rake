
desc "Vainly print out your model information"
task :vain_models => :environment do
    puts "TODO..."
    manifest = VainModels::Manifest.new
    manifest.models.each do |model|
      puts "#{model.name} => #{model.table_name}"
    end
end