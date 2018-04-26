# calendar

This application automatically ports user's google calendars to make it easier for groups to find time when everyone's free. Like when2meet, but better! Users select a date they want to meet, our application goes through user's schedule on given date and returns a free time slot where people are free. 

Team members: Tracy Lam, Geoffrey Wiederecht, Jessica Yeh
Demo Link: https://drive.google.com/file/d/1aIZj5i5N4majt9vZsut4wOgqwFCugMj0/view?usp=sharing

Models and Description:
User
	- has email and and 
	- has many events
Event
	- has a name, date (for now), with potential start and end time for future implementation
	- has many users
Schedule
	- stores user's calendar in the database
- also created a join time for users and events (many to many relationship)


Features:
- Users can connect their Google Calendar
- Users can view their events for a given date
- Users can compare their calendar with another calendar for a given date
- A free event between the two calendars is returned. (working out the bugs)
- Users can create a collaborated event to save in the database.
- Still need to properly connect User and Event


Division of Labor:
Jessica: Created models + database + controllers
Geoffrey: Created events 
Tracy: Bootstrap + CSS + Views




