import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReminderSettingsScreen extends StatefulWidget {
  @override
  _ReminderSettingsScreenState createState() => _ReminderSettingsScreenState();
}

class _ReminderSettingsScreenState extends State<ReminderSettingsScreen> {
  bool _reminderEnabled = false;
  TimeOfDay _selectedTime = TimeOfDay(hour: 8, minute: 0);
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadPreferences();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _reminderEnabled = prefs.getBool('reminderEnabled') ?? false;
      int hour = prefs.getInt('reminderHour') ?? 8;
      int minute = prefs.getInt('reminderMinute') ?? 0;
      _selectedTime = TimeOfDay(hour: hour, minute: minute);
    });
    if (_reminderEnabled) {
      _scheduleReminder();
    } else {
      _cancelReminder();
    }
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('reminderEnabled', _reminderEnabled);
    await prefs.setInt('reminderHour', _selectedTime.hour);
    await prefs.setInt('reminderMinute', _selectedTime.minute);
    if (_reminderEnabled) {
      _scheduleReminder();
    } else {
      _cancelReminder();
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _scheduleReminder() async {
    final now = DateTime.now();
    final scheduledDate = DateTime(now.year, now.month, now.day, _selectedTime.hour, _selectedTime.minute);
    final tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Reminder Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'ECG Labs Reminder',
      'Time to review your ECG studies!',
      tzScheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _cancelReminder() async {
    await _flutterLocalNotificationsPlugin.cancel(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminder Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Enable Reminder'),
              value: _reminderEnabled,
              onChanged: (value) {
                setState(() {
                  _reminderEnabled = value;
                });
              },
            ),
            ListTile(
              title: Text('Reminder Time'),
              subtitle: Text(_selectedTime.format(context)),
              trailing: Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _savePreferences();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Reminder settings saved!')),
                );
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}