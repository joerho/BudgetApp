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

- when a repeat is selected (daily, weekly, monthly, annually), a new entry is added to the repeats table in the database
- when "never" is selected, do nothing
- take out the option to select repeats in edit mode
- add a new table to manage repeats


6/10/2020

where to put the observer and actions
when the app starts immediately add an observer (appdelegate vs scenedelegate)
the action will take into account last opened, current date, rules (repeat table) and insert rows accordingly


6/19/2020

    - create new repeat instances (addnewexpenseviewcontroller)
    - create new expenses/incomes based on repeat instances (expenseviewcontroller)
    - delete a repeated instance -> prompts user for future instances (y/n) 
        - selecting yes will disable the recurring event
        
EDITING REPEATS
- selecting repeats in edit mode will show button for changing repeat. 
    if a rule for repeat exists, modify that entry
    if a rule does not exist, add a new entry

6/20/2020
How would a repeated entry have the information to the original entry or the repeat entry?




for every item in repeats
    fk_id = item[fk_id]
    get entry using fk_id
    recurring_type = item[recurring_type]
    sep_count = item[separation_count]
    day = item[day_of_week]
    week = item[week_of_month]
    month = item[month_of_year]
    last_opened = get_last_opened_date()
    
    if day,week,month happened between last_opened and cur_date
        add entry to expense/income
    else
        break
        

6/21/2020
observer will go in the home view controller
homeviewmodel has all the necessary components
will need to add a new component: repeats
