![Banner](/GeoTrigger/Images/GitHub-Banner.png?raw=true)



This is a sample project to demonstrate how to trigger GeoFence based push notifications on iOS devices. This project also demonstrates how to handle Region's that might have arbitruary sizes where setting percise region sizes might not be trival.

### Class Reference 
##### NotificationCenter.swift 
Sets permissions needed for notifications and fires the local push notification

##### LocationManager.swift
Inherits CLLLocationManager, exposes properties to be observied for the views. Handles region enter, exit events.

##### TaskManager.swift
Encapsulates task management logic

##### AppConfig.swift
You can modify/add new regions to test and define config properties such as thread sleep times.
