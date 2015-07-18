# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |v|
    v.gui = false      # adds a gui to virtuaBox locally
  end

  config.vm.provider :aws do |aws, override|

    override.vm.box = "dummy"               # overrides virtuabox config to use empty box as will load ami below...
    override.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"
    
    # swilson - FREE
    aws.access_key_id = 'AKIAISXSER7FRQKSJAUA'      # 
    aws.secret_access_key = '0TBzkwC/Fz5n3YfHQoLG9S5FApq8x/wbtXzmlOgd'  # 
    aws.keypair_name = 'selenium'       # 
    aws.security_groups = ["default"]
    override.ssh.username = 'ubuntu'
    override.ssh.private_key_path = './../pem-files/selenium.pem'
           
    # Shared Information
    aws.region = "us-west-2"
    aws.instance_type = "t2.micro"
    #aws.ami = 'ami-5dacad6d'        # ubuntu 12.04 instance-store amd64
    aws.ami = 'ami-13b0b123'		# ubuntu 12.04 precise HVM:EBS amd64 allows t2.micro
    
    aws.tags = {
      'Owner' => 'qa',
      'Name' => 'vagrant-webdriver',
      'webdriver' => 'true'
    }

  end

  config.vm.provision :shell, :path => "setup.sh"
  config.vm.network :forwarded_port, guest:4444, host:4444
  config.vm.network :forwarded_port, host: 9222, guest: 9222

end
