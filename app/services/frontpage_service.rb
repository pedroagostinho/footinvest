class FrontpageService

  def self.call
    new.call
  end

  def initialize
    @img_array = []
  end

  def call
    # Logic goes here
    html_content = open('https://24.sapo.pt/jornais/desporto').read
    doc = Nokogiri::HTML(html_content)

    doc.search('.newspaper .preview').each_with_index do |element|
      #@img_array << element.css('picture')[0]['data-original-src']
      @img_array << "https://#{element.css('picture img').attr('data-src').value[2..-1]}"
      # puts element.css('picture')[0]['data-original-src']
    end
    @img_array
  end
end


FrontpageService.call
