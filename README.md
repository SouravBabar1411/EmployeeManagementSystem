# EMS

Employee management system

## Add your files

cd existing_repo
git remote add origin https://gitlab.com/big-kitty-labs/ror-training/ems.git
git branch -M main
git push -uf origin main

Ruby version : 2.7.5


Rails version : 5.2.7.1


System dependencies : NA


Configuration : Create seed file for initial login in Admin menu


Database creation : Postgre sql

## Steps to create initial setup

1) git clone project-url
2) set up the rails and ruby version as mentioned above
3) rename database.yml.bkp to database.yml
3) create database
    rails db:create
4) resolving dependencies: bundle install 
5) for database schema: rake db:migrate  
6) for admin email and password: rake db:seed 