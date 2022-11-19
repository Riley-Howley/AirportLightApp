'''
Function Name: Light Controller
Description: This file controls what the lights
should do when the request has been received. 
'''

'''
Function Name: Send Data
Description: This file gets all the data that is within 10 ids of the max and sends
it to a json dump file which is displayed on the rendered Template for the request to
get the json for the application
'''

import MySQLdb
import time
import smbus
import json
import RPi.GPIO as GPIO
from flask import Flask, render_template

import MySQLdb

app = Flask(__name__)

bus = smbus.SMBus(1)
a0 = 0



GPIO.setmode(GPIO.BCM)
GPIO.setup(13, GPIO.OUT)
GPIO.setup(19, GPIO.OUT)
GPIO.setup(26, GPIO.OUT)

GPIO.output(13, GPIO.LOW)
GPIO.output(19, GPIO.LOW)
GPIO.output(26, GPIO.LOW)






def lightPattern():
    GPIO.output(13, GPIO.HIGH)
    GPIO.output(19, GPIO.HIGH)
    GPIO.output(26, GPIO.HIGH)
    time.sleep(0.1)
    GPIO.output(13, GPIO.LOW)
    GPIO.output(19, GPIO.HIGH)
    GPIO.output(26, GPIO.HIGH)
    time.sleep(0.1)
    GPIO.output(13, GPIO.LOW)
    GPIO.output(19, GPIO.LOW)
    GPIO.output(26, GPIO.HIGH)
    time.sleep(0.1)
    GPIO.output(13, GPIO.LOW)
    GPIO.output(19, GPIO.LOW)
    GPIO.output(26, GPIO.LOW)
    time.sleep(0.1)


@app.route("/")
def index():
    db = MySQLdb.connect(
 "localhost","pi","secret","project",cursorclass="MySQLdb.cursors.DictCursor")
    cursor = db.cursor(MySQLdb.cursors.DictCursor)
    myquery = "select max(id) as max from airport"
    cursor.execute(myquery)
    data = cursor.fetchall()
    print(data[0]['max'])
    maxID = data[0]['max']
    seQuery = f"select ID,SoundData from airport where ID >= {maxID - 10}"
    cursor.execute(seQuery)
    mydata = cursor.fetchall()
    #print(mydata)
    db.close()
    return json.dumps(mydata)

@app.route("/control")
def control():
    for i in range(1,50):
        lightPattern()
        time.sleep(0.1)
app.run(debug=True, host='0.0.0.0')
