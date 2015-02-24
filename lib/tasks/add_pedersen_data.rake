require 'roo'
include ActionView::Helpers::NumberHelper

task :add_pedersen_data => :environment do
  @owner = User.find_by_email('olof.pedersen@lingfil.uu.se') || User.first
  @project = Project.find(2)
  @institution = Institution.where(name: 'Vorderasiatisches Museum').first_or_create(name: 'Vorderasiatisches Museum')
  mfile = File.new("#{Rails.root}/public/uploads/main-import.xlsx")
  @classification = ItemClassification.where(name: 'Tontafel').first_or_create(name: 'Tontafel', parent_id: 1, description: 'import', creator_id: @owner.id, updater_id: @owner.id)

  # add_lists
  # for name in (1..15).map{|i| 'N'+i.to_s }.to_a do
  #   List.where(name: name).first_or_create(name: name, description: 'Import', project_id: @project.id, creator_id: @owner.id, updater_id: @owner.id)
  # end

  puts "Opening main file under #{mfile.path}... #{number_to_human_size(mfile.size)}"
  s = Roo::Excelx.new(mfile.path, nil, :ignore)
  header = s.row(1)

    puts "#{s.last_row} rows in main file"
    (2..s.last_row).each do |i|
      row = Hash[[header, s.row(i)].transpose]
      item = Item.find_by_excavation_number_and_excavation_index(row["Bab"].to_i, row['BabInd']) || Item.new
      item.excavation_number = row['Bab'].to_i
      item.excavation_index = row['BabInd']
      item.excavation_prefix = row["Grabung"]
      item.classification_id = @classification.id
      item.collection_id = Collection.where(shortcut: row["MusSig"]).first_or_create(shortcut: row["MusSig"], name: row["MusSig"], institution_id: @institution.id, creator_id: @owner.id, updater_id: @owner.id).id
      item.inventory_number = row["MusNr"]
      item.inventory_number_index = row["MusInd"]
      item.excavation_place = row["FOTell"]
      item.excavation_situation = "#{row['FO1']}; #{row['FO2']}; #{row['FO3']}; #{row['FO4']}; #{row['FOText']}"
      item.excavation_date = "#{row['GrDatum']}#{row['GrJahr']}"
      item.description = "BJoin: #{row['BJoin']}; BKorr: #{row['BKorr']};\r\nMJoin: #{row['MJoin']}; MKorr: #{row['MKorr']};Abklatsch: #{row['Abklatsch']}; Abguß: #{row['Abguß']};\r\n \r\nBeschreibung: #{row['FObj']}; Kod: #{row['Kod']};\r\nInhalt: #{row['Inhalt']}; Jahr: #{row['Jahr']}; Datum: #{row['Datum']};\r\n Text: #{row['Text']}; Zeil1: #{row['Zeil1']}; Zeil2: #{row['Zeil2']}; Sig: #{row['Sig']}; Arkiv: #{row['Arkiv']}; TextinArchiv: #{row['TextinArchiv']};\r\n Literatur: #{row['Literatur']}"
      item.dissov_id = row['Diss']
      item.mds_id = row['MusId']
      item.period = row['Period']
      item.dimensions = "#{row['Mas1']} x #{row['Mas2']} x #{row['Mas3']}"

      item.creator_id = @owner.id
      item.updater_id = @owner.id
      item.save!
      puts "#{item.excavation_number}#{item.excavation_index} added or updated"
    end

end
