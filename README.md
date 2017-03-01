# Blog

* Create database

Copy config/database.example.yml to config/database.yml and add user and password fields used by postgresql.

Then run

  `rake db:create && rake db:migrate`