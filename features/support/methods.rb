
def setup(setupTarget)
  # DRIVER DEFINITION
  ##### ##### ##### ##### ##### ##### #####
  #
  if (setupTarget == 'local')
    @driver = Selenium::WebDriver.for :firefox
  elsif (setupTarget == 'remote')
    @driver = Selenium::WebDriver.for(
    	:remote,
  	  :url => 'http://localhost:4444/wd/hub'
    )
  end
  #
  ##### ##### ##### ##### ##### ##### #####
end

def teardown()
  @driver.quit
end

def loadMainPage()
  startTime = Time.now

  @driver.navigate.to @mainPage

  endTime = Time.now
  loadTime = (endTime - startTime)

  #reportPageInfo('Main Page')

  return(loadTime)
end

def loadSignInPage()
  startTime = Time.now

  @driver.find_element(:id, "ctl00_MasterHeader_ctl00_uchead_SH_MasterPageHeaderSubmenu_ucWelcome_SignInURL").click

  endTime = Time.now
  loadTime = (endTime - startTime)

  return(loadTime)
end

def signInOut ()
  startTime = Time.now
  username = @driver.find_element(:id, "ctl00_CP_SignInUC1_UserNameContainer_txtUserName")
  username.send_keys(@username)

  password = @driver.find_element(:id, "ctl00_CP_SignInUC1_PasswordContainer_txtPassword")
  password.send_keys(@password)

  signin = @driver.find_element(:id, "ctl00_CP_SignInUC1_BtnLoginButton")

  signin.find_element(:id, "ctl00_CP_SignInUC1_BtnLoginButton").click

  endTime = Time.now
  loadTime = (endTime - startTime)

  #signout
  @driver.find_element(:id, "ctl00_MasterHeader_ctl00_uchead_SH_MasterPageHeaderSubmenu_ucWelcome_SignOut1").click

  return(loadTime)
end

def searchTime(searchstring)
  search = @driver.find_element(:id, "ctl00_MasterHeader_ctl00_uchead_GlobalSearchUC_TxtSearchKeyword")

  search.send_keys(searchstring)

  startTime = Time.now
  search.send_key :return

  endTime = Time.now
  searchTime = (endTime - startTime)

  @searchCount = @driver.find_element(:css => "[data-model='product']").find_element(:class,"count").find_element(:class,"count-value").text

  return(searchTime)
end

def logResults (mainPage, signInPage, signIn, totalSignIn, searchTime, searchCount)

  resultTime = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  fileName = "results/" + @resultsFile
  myFile = File.open(fileName, "a")
  myFile.puts resultTime.to_s + ',' + mainPage.to_s + ',' + signInPage.to_s + ',' + signIn.to_s + ',' + totalSignIn.to_s + ',' + searchTime.to_s + ',' + searchCount.to_s
  myFile.close

end