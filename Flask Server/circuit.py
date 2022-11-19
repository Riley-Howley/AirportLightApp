'''
Function Name: Read Analog Values
Description: This file also reads the values of the analog every second
and adds the data to the database 
'''

import MySQLdb
import time
import smbus

bus = smbus.SMBus(1)
a0 = 0

def getSoundAnalog():
    bus.write_byte(0x48,a0)
    value = bus.read_byte(0x48)
    time.sleep(1)
    print(value)
    return value
    
def storeData(value):
    db = MySQLdb.connect(
    "localhost","pi","secret","project")
    cursor = db.cursor()
    myquery = f"insert into airport values(0,{value})"
    cursor.execute(myquery)
    db.commit()
    db.close()
    
while True:
    storeData(getSoundAnalog())
    time.sleep(1)