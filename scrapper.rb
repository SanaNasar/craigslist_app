# scrapper.rb
require 'nokogiri'
require 'open-uri'
require 'awesome_print'


def filter_links(rows, regex)
  # takes in rows and returns uses

  # regex to only return links 
  # that have "pup", "puppy", or "dog"
  # keywords
  filtered = []
  # counter = 0
  rows.each do |row|
    test_text = row.css("a.hdrlnk").text
    if test_text.match(regex)
      puts "dog text #{test_text}" #for testing purpose
      path = row.css("a.hdrlnk").attribute("href")
      url = "http://sfbay.craigslist.org#{path}" 
      filtered.push(url)
    end
  end
  puts filtered
end

def get_todays_rows(doc, date_str)

  #  1.) open chrome console to look in inside p.row to see
  #  if there is some internal date related content
  # results = page.css(".txt, a").map do |link|
  # {title: link.text, url: link["href"]}

  #  2.) figure out the class that you'll need to select the
  #   date from a row

   #collect all rows
  rows = doc.css(".row")
  # iterate over all rows comparing the date
   results = []
   rows.select do |row|
    # if the text matches our regex
    regex = /(puppy|pup|dog)/ 
    row.css(".hdrlink").text.match(regex)
    if row.text.match(regex)
      row.css(".hdrlnk").text
      row.css(".hdrlnk").first["href"]
      results.push(row)
      ap row #testing
      puts row.text # testing
      results

      # #   date = row.css(".date").text
      # # if date.match(date_str)  && date.match(date_str).length
      # #   results.push(row)
      # end
    end
  end

end

def get_page_results
  # html = open("today.html")
  url = "today.html"
  doc = Nokogiri::HTML(open(url))
  get_todays_rows(doc,"Aug 12")
end

def search(date_str)
  get_page_results
  get_todays_rows(doc, date_str)
end

  #regex call
  

  # results = filter_links(rows, regex)


# want to learn more about 
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
today = Time.now.strftime("%b %d")
search(today)