require 'watir-webdriver'
require 'watir-webdriver/wait'
class FlightSearch
  def initialize(departAP,arriveAP,departDate,arriveDate)
    @departAP=departAP
    @arriveAP=arriveAP
    @departDate=departDate
    @arriveDate=arriveDate
  end

  def startsearch()
    browser=Watir::Browser.new :ff
    browser.goto('http://priceline.com')
    browser.link(:id,'tab-flights').click
#input data
    departBox=browser.text_field(:name,'DepCity')
    destBox=browser.text_field(:name,'ArrCity')
    departdateBox=browser.text_field(:name,'DepartureDate')
    destdateBox=browser.text_field(:name,'ReturnDate')
    departBox.set(@departAP)
    destBox.set(@arriveAP)
    departdateBox.set(@departDate)
    destdateBox.set(@arriveDate)
#click close button on calendar popout
    closeBtn=browser.button(:css,'.ui-datepicker-close')
    closeBtn.click
#confirm search
    searchBtn=browser.button(:id,'air-btn-submit-retl')
    searchBtn.click
#get result
    browser.span(:css,'.dollar').wait_until_present
    if(browser.div(:id,'filter-list').exist?)
    @pricelist=browser.div(:id,'filter-list').spans(:css,'.dollar')
    elsif(browser.div(:css,'.itineraries').exist?)
      @pricelist=browser.div(:css,'.itineraries').spans(:css,'.dollar')
      end
    # pricelist.each do |span|
    # puts span.text
    # end
    @descriplist=browser.divs(:css,'.stops')
    #  descriplist.each do |div|
    #   puts div.text.gsub(/\n/,' ')
    # end
    number=@pricelist.length
    for i in 0.. number-1
      puts @pricelist[i].text
      puts @descriplist[i].text.gsub(/\n/,' ')
    end
  end


end
search=FlightSearch.new('SFO','PEK','06/01/2015','06/30/2015')
search.startsearch