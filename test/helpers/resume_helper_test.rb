require 'test_helper'

class ResumeHelperTest < Minitest::Test
  include ResumeHelper

  def test_foo
    stub_request(:get, 'https://www.technowizardry.net/author/adam-jacques/feed.xml')
      .to_return(body: File.new('./test/data/blog.rss'), status: 200)

    expected = [
      {
        description: "Shortened … <a href=\"https://www.technowizardry.net/2022/01/accurate-local-home-energy-monitoring-part-1/?mtm_campaign=resume_website\" class=\"more-link\">Continue reading<span class=\"screen-reader-text\"> \"Accurate, Local Home Energy Monitoring: Part 1 – Hardware\"</span></a>",
        title: "Post 1",
        link: "https://www.technowizardry.net/2022/01/accurate-local-home-energy-monitoring-part-1/?mtm_campaign=resume_website"
      },
      {
        description: "Shortened … <a href=\"https://www.technowizardry.net/2022/01/centurylink-pppoe-gigabit-service-on-mikrotik-routeros/?mtm_campaign=resume_website\" class=\"more-link\">Continue reading<span class=\"screen-reader-text\"> \"CenturyLink Gigabit service on Mikrotik RouterOS with PPPoE and IPv6\"</span></a>",
        title: "Post 2",
        link: "https://www.technowizardry.net/2022/01/centurylink-pppoe-gigabit-service-on-mikrotik-routeros/?mtm_campaign=resume_website"
      }
    ]

    assert_equal expected, sample_blog_posts
  end
end
