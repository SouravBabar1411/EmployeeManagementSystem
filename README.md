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
Version: 9.1 and up are supported.

## Steps to create initial setup

1. git clone project-url
2. set up the rails and ruby version as mentioned above
3. rename database.yml.bkp to database.yml
4. create database
   rails db:create
5. resolving dependencies: bundle install
6. for database schema: rake db:migrate
7. for admin email and password: rake db:seed
8. social login with google
9. implemented email confirmable while user sign up