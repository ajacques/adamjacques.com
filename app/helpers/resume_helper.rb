module ResumeHelper
  def date_or_present(date)
    if date
      year_month(date)
    else
      t('time_periods.present')
    end
  end

  def year_month(date)
    l date, format: :month_year
  end
end
