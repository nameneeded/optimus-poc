
Given /^that I am testing BestBuy$/ do
  @mainPage = 'http://www.bestbuy.ca'
  @username = 'POC@elasticpath.com'
  @password = '3lasticPath'
  @resultsFile = 'bestbuyresults.csv'
  @pfFile = 'bestbuypf.csv'
  @pfAll = true
  @search = 'Go Pro Hero'
  @resultTime = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  @maxPageLoad = 6
  @maxSignIn = 10
end

When /^I test locally/ do
  @setupTarget = 'local'
end

When /^I test remotely/ do
  @setupTarget = 'remote'
end

And /^I time the main page$/ do
  setup(@setupTarget)
    @loadMainPage = loadMainPage()
  teardown()
end

And /^I time the sign-in page$/ do
  setup(@setupTarget)
    loadMainPage()
    @loadSignInPage = loadSignInPage()
  teardown()
end

And /^I time sign-in as a registered user$/ do
  setup(@setupTarget)
    loadMainPage()
    loadSignInPage()
    @loginTime = signInOut()
  teardown()
end

And /^I time complete sign-in as a registered user$/ do
  setup(@setupTarget)
    startTime = Time.now
    loadMainPage()
    loadSignInPage()
    signInOut()
    endTime = Time.now
    loadTime = (endTime - startTime)
    @totalSignIn = loadTime

    caller = 'TotalSignIn'
    if loadTime < @maxSignIn
      logPassFail(caller, true)
    else
      logPassFail(caller, false)
    end

  teardown()
end

And /^I do a search for Go Pro Hero$/ do
  setup(@setupTarget)
    loadMainPage()
    @searchTime = doSearch(@search)
  teardown()
end

Then /^I write the results to the results files$/ do
  logResults(@loadMainPage,@loadSignInPage,@loginTime,@totalSignIn,@searchTime,@searchCount)
end