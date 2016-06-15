# $ bundle exec rake tender:close_outdated RAILS_ENV=development
 
namespace :tender do
  task close_outdated: :environment do
    puts "#{Time.now} Starting close_outdated."
    tenders = Tender.where(status_id: '1').where('data_end < ?', Time.zone.now)
    puts "Finding #{tenders.count} outdated tenders"
    if tenders.count > 0
      TendersMailer.delay.tender_status_change(tenders)
      puts "Status change for tenders: #{tenders.map(&:id).join(',')}. Sending mail"
      tenders.update_all(status_id: '2')
    else
      puts 'No objects to change the status'
    end
    puts "#{Time.now} Done"
  end
end
