

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/task_model.dart';
import '../screens/notified_details_page.dart';


class NotifyHelper{
  
FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
   // tz.initializeTimeZones();
   _configureLocalTimezone();


 final AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
       android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  }

   displayNotifications({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics =  const AndroidNotificationDetails(
        'your channel id', 'your channel name', 
        importance: Importance.max, priority: Priority.high);
 
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,);
    await flutterLocalNotificationsPlugin.show(
      0,
      // 'You change your theme',
      // 'You changed your theme back !',
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }
  
//sec of show notifications
   scheduledNotification(int hour , int minutes, TaskModel task ) async {
     await flutterLocalNotificationsPlugin.zonedSchedule(
         task.id!.toInt(),
         task.title,
         task.note,
         _convertTime(hour, minutes),
         //tz.TZDateTime.now(tz.local).add( Duration(seconds: minutes)),
         
         const NotificationDetails(
             android: AndroidNotificationDetails('your channel id',
                 'your channel name',)),
         androidAllowWhileIdle: true,
         uiLocalNotificationDateInterpretation:
             UILocalNotificationDateInterpretation.absoluteTime,
             matchDateTimeComponents: DateTimeComponents.time,
             payload: "${task.title}|"+"${task.note}|"
             );

   }

  tz.TZDateTime _convertTime(int hour, int minutes){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = 
             tz.TZDateTime(tz.local, now.year, now.month, now.day,hour,minutes);
    if(scheduleDate.isBefore(now)){
      scheduleDate = scheduleDate.add(const Duration(days:1));
    }
      return scheduleDate;
  }

 Future<void>_configureLocalTimezone()async{
  tz.initializeTimeZones();
      final String timezone = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezone));
 }

void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print("notification payload: $payload");
    } else{
      print("notifications Done");
    }
    if(payload=="Theme Changed"){
      print("nothing navigate to");
    }else{
     Get.to(()=>NotifiedPage(label:payload));
    }
    
}
  
}