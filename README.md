# Gradebook

A simple gradebook app for teachers and students. A student may log in and view their GPA by semester, as well as grades by courses enrolled. A teacher is able to view all the courses that they teach,
and all students and their respective grades in the course.

Lastly, administrators can view enrollment numbers by semester, and they can view average GPA by course.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What you need...

```
Ruby 2.4.1
Rails 5.1.4
```

### Installing

Getting development running. First clone the repo to your computer. Then run the following commands.

```
bundle install
rake db:create
rake db:migrate
rake db:seed
```

That should install the gems locked to this repo, create your database, run all migrations, and lastly seed the database.

```
rails server
```

After running rails server, go to localhost:3000 in your web browser. The following are logins available to you.

* Admin
username: admin
password: password

* Teacher
username: teacher0, teacher1, or teacher2
password: password

* Student
username: student0, student1... to student50
password: password

## Running the tests

All feature and model tests can be run using the ```rspec``` command.