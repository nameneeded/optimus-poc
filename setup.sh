# added to source
#!/bin/sh
set -e

if [ -e /.installed ]; then
  echo 'Already installed.'

else
  echo ''
  echo 'INSTALLING'
  echo '----------'
  
  # Add Google public key to apt
  wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -

  # Add Google to the apt-get source list
  echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list

  # Update app-get
  apt-get update

  # Install Java, Chrome, Xvfb, unzip, firefox, ruby-dev
  apt-get -y install openjdk-7-jre google-chrome-stable xvfb unzip firefox ruby-dev zlib1g-dev

  # Install Ruby gems
  gem install selenium-webdriver
  gem install cucumber
  gem install rspec
  gem install rubyXL

  # Set the timezone to America/Vancouver
  timedatectl set-timezone America/Vancouver

  # Set the datetime to be accurate
  ntpdate pool.ntp.org

  # Get chromedriver, selenium-server and phantomjs
  # Unzip them and move them to /usr/local/bin
  # Set chromdriver, phantomjs as executable
  cd /tmp

  wget "http://chromedriver.storage.googleapis.com/2.9/chromedriver_linux64.zip"
  wget "http://selenium-release.storage.googleapis.com/2.46/selenium-server-standalone-2.46.0.jar"
  wget "http://phantomjs.googlecode.com/files/phantomjs-1.9.1-linux-x86_64.tar.bz2"

  unzip chromedriver_linux64.zip
  mv chromedriver /usr/local/bin
  sudo chmod +x /usr/local/bin/chromedriver

  mv selenium-server-standalone-2.46.0.jar /usr/local/bin

  tar xjf phantomjs-1.9.1-linux-x86_64.tar.bz2
  mv phantomjs-1.9.1-linux-x86_64 /usr/local/bin/phantomjs 
  sudo chmod +x /usr/local/bin/phantomjs

  # So that running `vagrant provision` doesn't redownload everything
  touch /.installed
fi

# Start Xvfb, Chrome, and Selenium in the background

echo "Run as root ..."

# Add the cronjob to crontab - change this to use Ubuntu user?
#echo "Adding cronjob"
#crontab /vagrant/cronjob

# Export Display
echo "export display ..."
export DISPLAY=:10

# Change to /vagrant and run local commands
cd /vagrant

# Start Xvfb
echo "Starting Xvfb ..."
Xvfb :10 -screen 0 1366x768x24 -ac &

# Start Chrome
echo "Starting Google Chrome ..."
google-chrome --remote-debugging-port=9222 &

# Start Selenium
echo "Starting Selenium ..."
cd /usr/local/bin
nohup java -jar ./selenium-server-standalone-2.46.0.jar &

