### STEP #1: Setup

 Open http://sqlfiddle.com/ or similar environment for running SQL queries
and run queries from create.sql to create a table and fill it with values.  


 ### STEP #2: PREREQUISITES

The app collects data from devices every time they connect/disconnect. 

Once device connects to the app, the app receives a json: 

Example: 
 {
    "deviceId": '1111111111111111111111111',
    "connectedAt" '2022-12-12 20:00'
  }

A new row with "device_id" and "connected_at" is added to the table events, 
and a "disconnected_at" would be NULL (device has been online since the connection time).

When device disconnects, the app receives another json: 

Example: 
 {
    "deviceId": '1111111111111111111111111',
    "disconnectedAt" '2022-12-12 21:00'
  }

And the row with the latest connection time where "disconnected_at" IS NULL will be updated 
with '2022-12-12 21:00'.


However, due to a recent outage on the server, the app missed some disconnection events and never 
updated the "disconnected_at" fields for some rows.
Because the events are forever gone, it's impossible to know the real disconnection time for each device.

The company agreed that the disconnection times for devices will be the same as times 
of next connection event.

### STEP #3A: TASK: UPDATE

Write a query that'll find all disconnected_at fields with null values and update them with the next "connected_at" time for that device. (See events.UPDATE.png) 

If disconnected_at is null but that is the latest event that happened to the device, it means that device
is online and that disconnected_at should stay NULL

### STEP #3B: TASK: DELETE

Write the query that'll delete all rows where disconnect is null EXCEPT for the most recent connection 
event with an empty disconnect. (See events.DELETE.png) 
