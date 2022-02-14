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
    tracer = OpenTelemetry.tracer_provider.tracer('my-tracer')
    tracer.in_span('sample_blog_posts') do |_span|
      resp = Faraday.get('https://www.technowizardry.net/author/adam-jacques/feed/')

      doc = Nokogiri.XML(resp.body)
      posts = doc.xpath('/rss/channel/item')
      posts.map do |post|
        uri = URI.parse(post.at_xpath('link').text)

        # Insert the campaign tag
        query = Rack::Utils.parse_query(uri.query)
        query['mtm_campaign'] = 'resume_website'
        uri.query = Rack::Utils.build_query(query)
        post[:link] = uri.to_s
        html = Nokogiri::HTML5::DocumentFragment.parse(post.at_xpath('description').text)
        more = html.at_css('.more-link')
        more['href'] = uri.to_s if more.present?

        {
          description: html.to_html,
          title: post.at_xpath('title').text,
          link: uri.to_s
        }
      end
    end
  rescue SocketError, Errno::ENETUNREACH, OpenSSL::SSL::SSLError => e
    Sentry.capture_exception(e)
    []
  end
end
