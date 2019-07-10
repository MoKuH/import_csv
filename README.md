## Description


[![Build Status](https://travis-ci.org/MoKuH/import_csv.png)](https://travis-ci.org/MoKuH/import_csv)
[![Code Climate](https://codeclimate.com/github/MoKuH/import_csv/badges/gpa.svg)](https://codeclimate.com/github/MoKuH/import_csv)
[![Test Coverage](https://codeclimate.com/github/MoKuH/import_csv/coverage.svg)](https://codeclimate.com/github/MoKuH/import_csv/coverage)

This is a simple project importing csv file of users
It also allow user view/edit and destroy
It uses simple_form and bootstraps


## Requirements

This project currently works with:

* Rails 5.2.x
* PostgreSQL
* ruby-2.6.2

## Installation


```
cp config/database.example.yml config/database.yml #then adapt your postgres username/password
bundle install
rake db:create
rake db:migrate
```
## Features

- Import users' csv file
- See all users with pagination
- Show user
- Edit user
- Delete user
- Clear users
- Search user by name
- Sort user by attribute

## Demo
[https://import-users.jbbernard.com](https://import-users.jbbernard.com)

Imported data are limited to 200 rows 

## Test
To run tests:
```
rspec
```
