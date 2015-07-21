
Given /^That I am testing BestBuy$/ do
  @mainPage = 'http://www.bestbuy.ca'
  @username = 'POC@elasticpath.com'
  @password = '3lasticPath'
  @resultsFile = 'bestbuyresults.csv'
  @search = 'Go Pro Hero'
end

When /^I test remotely/ do
  @setupTarget = 'remote'
end

And /^I time the main page$/ do
  setup(@setupTarget)
    @loadMainPage = loadMainPage()
    puts @loadMainPage
  teardown()
end

And /^I time the sign-in page$/ do
  setup(@setupTarget)
    loadMainPage()
    @loadSignInPage = loadSignInPage()
    puts @loadSignInPage
  teardown()
end

And /^I time sign-in as a registered user$/ do
  setup(@setupTarget)
    loadMainPage()
    loadSignInPage()
    @loginTime = signInOut()
    puts @loginTime
  teardown()
end

And /^I time complete sign-in as a registered user$/ do
  setup(@setupTarget)
    startTime = Time.now
    loadMainPage()
    loadSignInPage()
    signInOut()
    endTime = Time.now
    @totalSignIn = (endTime - startTime)
    puts @totalSignIn
  teardown()
end

And /^I do a search for Go Pro Hero$/ do
  setup(@setupTarget)
    loadMainPage()
    @searchTime = searchTime(@search)
    puts @searchTime
    puts @searchCount
  teardown()
end

Then /^I write the results to the results file$/ do
  logResults(@loadMainPage,@loadSignInPage,@loginTime,@totalSignIn,@searchTime,@searchCount)
end