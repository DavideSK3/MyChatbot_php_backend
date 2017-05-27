# Backend for SmartChats Android Application.

Author: davidebelli95@gmail.com
Thesis and LPSMT Project for Bachelor Degree in Computer Science at University of Trento

How to create and run your own database:
1) Clone/Download this Github project
2) Create and setup a new Heroku App (here you can find a step by step tutorial about it: https://devcenter.heroku.com/articles/getting-started-with-php#introduction)
3) Create a MariaDB database on your Heroku App by using JawsDB add-on. (You need a certified account to install such add-on).
4) Configure your DB and import the latest backup provided, or create your own tables using the Create queries provided. (further details: https://devcenter.heroku.com/articles/jawsdb)
5) Setup the Global Heroku variable JAWSDB_MARIA_URL to containt the URL to your MySql database (all details in your add-on page, under Heroku app).
6) Make sure to set your own client App to check for the endpoint you created and not the default one, under the Java Class "Endpoints"
7) Many tools are available to help you out with debug if you find problems along the way. PostMan allows you to test HTTP Requests without using a client app. HeidiSQL provides an intuitive graphic interface to work on the database without using the default CLI.