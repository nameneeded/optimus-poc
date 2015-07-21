require 'selenium-webdriver'
require 'test/unit'
include Test::Unit::Assertions

startTime = Time.now

# Use this to run against the headless unit redirected on port 4444
#@driver = Selenium::WebDriver.for(
#	:remote,
#	:url => 'http://localhost:4444/wd/hub'
	#:url => 'http://52.27.243.242:4444/wd/hub'
#	)

# Use this to run locally against Firefox
@driver = Selenium::WebDriver.for :firefox

# URL to hit
@driver.navigate.to "http://google.com"

# Generate a random number to use for search, confirmation, and screenshot name
number = rand(1000)
	
element = @driver.find_element(:name, 'q')
element.send_keys number.to_s
element.submit

wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
wait.until { @driver.find_element(:id => "resultStats") }
resultStats = @driver.find_element(:id => "resultStats").text
	
@driver.save_screenshot(number.to_s + '-screenshot.png')

expected = @driver.title
actual = number.to_s + ' - Google Search'

puts 'Page Title: ' + actual.to_s
puts 'Results Stats: ' + resultStats.to_s

assert_equal(expected, actual, 'Actual: ' + actual.to_s + ' - Expected: ' + expected.to_s)

@driver.quit

endTime = Time.now

puts 'Run Time: ' + (endTime - startTime).to_s + ' seconds.'
