# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'json'

#occi_blocs
json_text = File.read(Rails.root.join('db','occi_blocs.json'))
JSON.parse(json_text).each do |occi_bloc|
  bloc = Bloc.find_by(code: occi_bloc['code'])
  if bloc
  	bloc.update!(occi_bloc)
  else
   Bloc.create!(occi_bloc)
  end
end
puts Bloc.where(jap: false).count

#jap_blocs
json_text = File.read(Rails.root.join('db','jap_blocs.json'))
JSON.parse(json_text).each do |jap_bloc|
  bloc = Bloc.find_by(code: jap_bloc['code'])
  if bloc
  	bloc.update!(jap_bloc)
  else
   Bloc.create!(jap_bloc)
  end
end
puts Bloc.where(jap: true).count