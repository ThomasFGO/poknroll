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
require 'csv'



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

#expansions
json_text = File.read(Rails.root.join('db', 'occi_lists','sv.json'))
JSON.parse(json_text).each do |expansion|
  existing_expansion = Expansion.find_by(code: expansion['code'])
  if existing_expansion
  	existing_expansion.update!(rank: expansion['rank'],
   	code: expansion['code'],   	
   	fr_name: expansion['fr_name'],   	
   	fr_release: expansion['fr_release'],  	
   	en_name: expansion['en_name'],
   	us_release: expansion['us_release'],
   	jap_name: expansion['jap_name'],
   	jap_release: expansion['jap_release'],
   	classic_size: expansion['classic_size'],
   	full_size: expansion['full_size'],
   	category: expansion['category'],
   	fr_logo_url: expansion['fr_logo_url'],
   	en_logo_url: expansion['en_logo_url'],
   	symbol_url: expansion['symbol_url'],
   	bloc: Bloc.find_by(code: expansion['bloc_code'])
  		)
  else
   Expansion.create!(rank: expansion['rank'],
   	code: expansion['code'],   	
   	fr_name: expansion['fr_name'],   	
   	fr_release: expansion['fr_release'],  	
   	en_name: expansion['en_name'],
   	us_release: expansion['us_release'],
   	jap_name: expansion['jap_name'],
   	jap_release: expansion['jap_release'],
   	classic_size: expansion['classic_size'],
   	full_size: expansion['full_size'],
   	category: expansion['category'],
   	fr_logo_url: expansion['fr_logo_url'],
   	en_logo_url: expansion['en_logo_url'],
   	symbol_url: expansion['symbol_url'],
   	bloc: Bloc.find_by(code: expansion['bloc_code'])
   	)
  end
end
puts Expansion.count

=begin

csv_text = File.read(Rails.root.join('db', 'occi_lists', 'ss.csv'))
csv = CSV.parse(csv_text, col_sep: ';', headers: :first_row, :encoding => 'ISO-8859-1')
csv.each do |row|
  code = row['code']
  symbol_url = row['symbol_url']
  Cloudinary::Uploader.upload("#{symbol_url}",:public_id => "#{code}",:folder => "lists/symbols")
end

=end