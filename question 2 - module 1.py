# -*- coding: utf-8 -*-
"""
Created on Tue May 25 13:43:28 2021

@author: JMaddox
"""

import time
import datetime as dt

from datetime import datetime
from datetime import timedelta
from datetime import date
import locale
from dateutil.relativedelta import *

print('Birthday Calculator')
today = date.today()
todayt = datetime.today()
t = today. strftime("%A, %B %d, %Y")

current_month = today.month

yesterday = today - timedelta(days=1)
# y = yesterday. strftime("%B-%d-%Y")

tomorrow = today + timedelta(days=1)
# tm = tomorrow. strftime("%B-%d-%Y")

# print(type(today))
# print(type(todayt))
# print(type(yesterday))
# print(type(tomorrow))

def get_birthday():
    birthday_str = input('Enter birthday (MM/DD/YY): ')
    birthday_input = datetime.strptime(birthday_str, '%m/%d/%y')
    dob = birthday_input.strftime('%Y , %m , %d')
    dob = datetime.strptime(dob, '%Y , %m , %d').date()
    print('Birthday: ' + birthday_input.strftime('%A, %B %d, %Y'))
    return dob

def main():
    
    while True:
        name = input('Enter name: ')
        
        dob = get_birthday()
        
        print('Today:',t)
        
        age = relativedelta(today, dob)
        age = age.years
        print(name, "is", age ,"years old")
        
        dob_month = dob.month
        
        if dob == today:
            print(name, "'s birthday is today!")
        elif dob == yesterday:
            print(name, "s birthday was yesterday!")
        elif dob == tomorrow:
            print(name, "s birthday is tomorrow!")
        else:
            if dob_month > current_month:
                birthday = date(today.year, dob.month, dob.day)
                days_until_birthday = (birthday-today).days
                print(name,"'s birthday is in "+ str(days_until_birthday) +" days.")
                
            elif dob_month == current_month:
                    if today.day > dob.day:
                        birthday = date(today.year, dob.month, dob.day)
                        days_until_birthday = (birthday-today).days
                        birthday_date = days_until_birthday + 365
                        print(name,"'s birthday is in "+ str(birthday_date) +" days.")
                    else:
                        birthday = date(today.year, dob.month, dob.day)
                        days_until_birthday = (birthday-today).days
                        print(name,"'s birthday is in "+ str(days_until_birthday) +" days.")
                
            else:
                birthday = date(today.year, dob.month, dob.day)
                days_until_birthday = (birthday-today).days
                birthday_date = days_until_birthday + 365
                print(name,"'s birthday is in "+ str(birthday_date) +" days.")
                
        result = input('Continue? (y/n): ')
        if result.lower() !='y':
            print('Bye!')
            break
        
if __name__ == '__main__':
    main()