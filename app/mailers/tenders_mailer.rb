class TendersMailer < ApplicationMailer
  default from: 'tenders@tis-ruda.com',
          template_path: 'mailers/tenders'

  def tender_created(id)
    @tender = Tender.find(id)
    mail to: 'it@tis-ruda.com', subject: 'ООО "ТИС-РУДА" Создан новый тендер'
  end

  def tender_destroyed(id)
    @tender = Tender.find(id)
    mail to: 'it@tis-ruda.com', subject: 'ООО "ТИС-РУДА" Тендер удален'
  end

  def new_tender_for_users(user_id, tender_id)
    @user = User.find(user_id)
    @tender = Tender.find(tender_id)
    mail to: @user.email, subject: 'ООО "ТИС-РУДА" Создан тендер, который может вас заинтересовать'
  end

  def tender_results(tender_id, user_id)
    @tender = Tender.find(tender_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'ООО "ТИС-РУДА" Результаты окончания тендера'
  end

  def tender_closed_without_winner(tender_id, user_id)
    @tender = Tender.find(tender_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'ООО "ТИС-РУДА" Тендер окончен без победителя'
  end

  def started_second_stage(tender_id, user_id)
    @tender = Tender.find(tender_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'ООО "ТИС-РУДА" Запущен II тур тендера'
  end

  def tender_status_change(tenders)
    @tenders = tenders
    @tenders.each do |tender|
      mail to: tender.manager.email, subject: 'ООО "ТИС-РУДА" Тендер окончен'
    end
  end
end
