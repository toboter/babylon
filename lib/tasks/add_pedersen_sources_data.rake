require 'roo'
include ActionView::Helpers::NumberHelper

task :add_pedersen_sources_data => :environment do
  @owner = User.find_by_email('olof.pedersen@lingfil.uu.se') || User.first
  @project = Project.find(2)
  @institution = Institution.where(name: 'Vorderasiatisches Museum').first_or_create(name: 'Vorderasiatisches Museum')
  @predicate = Predicate.where(name: 'is_depicted_in').first_or_create(name: 'is_depicted_in', inverse_name: 'depicts', scope_type: 'Action', description: 'import')
  mfile = File.new("#{Rails.root}/public/uploads/phbab-import.xlsx")

  puts "Opening sources file under #{mfile.path}... #{number_to_human_size(mfile.size)} for Olof Pedersen data."
  s = Roo::Excelx.new(mfile.path, nil, :ignore)
  header = s.row(1)

    puts "#{s.last_row} rows in sources file"
    (2..s.last_row).each do |i|
      row = Hash[[header, s.row(i)].transpose]
      item = Item.where(excavation_prefix: row['Prefix'], excavation_number: row['ExcavationId'].to_i, excavation_index: row['ExcavationInd']).first
      source = Source.where(name: row['SourceName']).first_or_create(name: row['SourceName'], source_type: 'photographic', author_id: 2, creator_id: @owner.id, updater_id: @owner.id, original_date: Time.now.years_ago(100), comment: 'original date and author incorrect')
      action = Action.find_by_actable_type_and_actable_id_and_source_id("Item", item.id, source.id) || Action.new
      action.actable = item
      action.source_id = source.id
      action.predicate_id = @predicate.id
      action.target = row['Position']
      action.creator_id = @owner.id
      action.updater_id = @owner.id
      action.save!
      puts "#{action.source.name} added to #{action.actable.name}"
    end

end

