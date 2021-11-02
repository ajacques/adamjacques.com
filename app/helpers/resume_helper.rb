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

  def sample_blog_posts
    resp = Net::HTTP.get(URI.parse('https://www.technowizardry.net/author/adam-jacques/feed/'))
    SimpleRSS.parse(resp).items
  rescue SocketError, Errno::ENETUNREACH, OpenSSL::SSL::SSLError => e
    Sentry.capture_exception(e)
    []
  end
end
