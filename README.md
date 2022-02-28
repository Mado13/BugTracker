# Ticket Manager

Welcome all IT teams out there for my Ticket Manager App,

Now there is a way for you to follow your department bugs, open tickets, follow up
on tickets, leave comments, manage department users and more to come...

* Rails 6 + Ruby 2.7

* PostgreSQL

* In order to run the app locally:

  1. clone the repository.

  2. install postgresql on your local machine:

    ```
    brew install postgresql
    ```
  3. To get the application up and running, please make sure you are using Ruby 2.7.4, otherwise   go to the Gemfile and change it to the version you currently have. Then please run:

  ```
  bundle install
  ```

  4. To migrate and seed the database with mock data, please run:

  ```
  rake db:create db:migrate db:seed
  ```

  5. Run the server, Go to http://localhost:3000 and register your user.


* The app is also Deployed and you can go to:

  https://ticket-manager-13.herokuapp.com
