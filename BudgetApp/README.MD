April 17 2020

Need to develop:
    - Repeat functionality
    - Settings page to choose month for home page
    - Graphs of some sort

Bugs:
    - Some entries will make the app crash on edit

Add:
    - App Icon
    - Launch Screen



5/21/2020

Bugs: 
    - Changing date will not automatically sort the tableview
    
6/8/2020

Repeat functionality
    - create a different table in the database that keeps track of repeats
    - how do I make it so that I can discontinue the repeat functionality?
        - just delete the entry in the new table!
    - currently "repeats" is part of both tables, expense and income
    - new table (primary_key, description, type, start_date, end_date, interval)
    - might have to create a new uitableview to manage repeats
    
    

create a small program to back up current database into a csv file
might have to re-do database
convert existing data in to csv, modify csv, convert back to database, upload into filesystem in the app

6/9/2020

- when a repeat is selected (daily, weekly, monthly), a new entry is added to the repeats table in the database
- when "never" is selected, do nothing

