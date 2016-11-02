require 'open-uri'


# a = Mechanize.new { |agent|
#   agent.user_agent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10B350 Safari/8536.25'
# }


class Item
  class << self
    def parse
      items = []
      # debugger
      Nokogiri::HTML(download('https://us.letgo.com/en')).css('.item:not(.sell-now-banner)').each do |item|
        puts item.text

        items << {
          url: item.css('a.img')[0].attr('href'),
          image: item.css('a.img img')[0].attr('src').gsub('?resize=175:*', ''),
          title: item.css('a.title')[0].text,
          city: item.css('span.city')[0].text
        }

      end
      items
    end

    private

    def download(url)
      open(url, {
        'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Encoding' => 'gzip, deflate, sdch, br',
        'Accept-Language' => 'en-US,en;q=0.8,ru;q=0.6',
        'Cache-Control' => 'no-cache',
        'Connection' => 'keep-alive',
        'Cookie' => 'country_code=US; PHPSESSID=a79a3d6mpuk1vhipas1bhl2et7; device_view=full; cookieNotificacion=1; D_SID=67.250.63.101:G1j07tNKXrXy4/pL5+Xjb7qiUHivZdf8adPvL7Dren0; G_ENABLED_IDPS=google; directAccessTop=1; _ga=GA1.3.1665307807.1478085470; _ga=GA1.2.1665307807.1478085470; D_PID=3A2B14FB-D0F6-336D-93C0-2F285A24505F; D_IID=A7A0C257-F653-3A33-8790-5BBA5B4FEF3D; D_UID=40A62275-3F91-39FD-AB7F-942F89C239E3; D_HID=cig1V+DOAqoSUoZwLA8/xlvEBJl+yAhT3/xKQnyvGgQ; D_ZID=8579678C-B713-3CF0-BC4A-FB62691FE580; D_ZUID=F6EEF9B5-190D-3479-BCB2-AB0922AAAD6D',
        'Host' => 'us.letgo.com',
        'Pragma' => 'no-cache',
        'Referer' => 'https://us.letgo.com/en/i/jordan-12s-size-11_9467fdce-1063-48c1-8521-3f62cf884b7f',
        'User-Agent' => 'Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10B350 Safari/8536.25'
      }).read
    end
  end
end

