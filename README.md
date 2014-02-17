vagrant-centos64-lamp
=====================

A ready-to-use vagrant template of a Centos 6.4 LAMP server for running
PHP applications.

What is this exactly?
=====================
This is a development platform for PHP on CentOS 6.4. It contains
a configured phpMyAdmin for your convenience (user: root,
password: NULL).

Usage
=====
1. Install vagrant
2. Install Virtual box (Windows XP users can experiment problems
   installing VirtualBox)
3. Install GIT.
4. (If you work on windows) Include the '...\Git\bin' folder in the PATH
   environment variable where '...' is the route where you installed GIT
5. Create the folder where you want to save the project.
6. Open the console and cd to this folder
7. Run 'git clone https://github.com/omoya/medb_devenv.git'
8. cd into the 'medb_devenv' folder
9. Run 'vagrant up'
10. You will see an '/htdocs' folder. The contents of this folder will
   be served from /var/www/html in the VM and from localhost:8070 in
   the host machine (your Windows, MacOs or Linux distribution).

 If you are able to see a welcome message at 'localhost:8070', it means
 that you installed successfully the development environment.
 
 The '/htdocs' folder in 'medb_devenv' is equivalent to the '/htdocs'
 folder in XAMPP. You can copy html or PHP files into this folder and run
 them from localhost:8070.
 
 This will let you check in your machine any change you do in the master
 or extra branches, running the site under similar conditions to these of
 the production server.
 
 You can also edit or add in your machine the site files  and 
 synchronize changes with the Github repository.