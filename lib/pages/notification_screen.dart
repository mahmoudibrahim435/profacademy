// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profacademy/pages/account_sreen.dart';
import 'package:profacademy/pages/corses_screen.dart';
import 'package:profacademy/pages/home_screen.dart';
import 'package:profacademy/widgets/navigation_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationScreen();
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<NotificationItem> notifications = [];
  bool isLoading = true;
  bool hasError = false;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _initNotifications();
    _requestPermissions();
    _fetchNotifications();
  }

  Future<void> _requestPermissions() async {
    try {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      
      bool grantedNotificationPermission = false;

      // Check if the platform is Android and if the permission is needed
      final status = await Permission.notification.status;
      if (status.isGranted) {
        grantedNotificationPermission = true;
        print('Notification permission already granted');
      } else {
        final result = await Permission.notification.request();
        if (result.isGranted) {
          grantedNotificationPermission = true;
          print('Notification permission granted');
        } else {
          print('Notification permission denied');
        }
      }
    } catch (e) {
      print('Error requesting notification permissions: $e');
    }
  }

  Future<void> _initNotifications() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      final InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      final bool? initialized = await flutterLocalNotificationsPlugin
          .initialize(
            initializationSettings,
            onDidReceiveNotificationResponse: (NotificationResponse response) {
              // Handle notification tap
              print('Notification tapped: ${response.payload}');
            },
          );

      if (initialized == true) {
        print('Local notifications initialized successfully');
      } else {
        print('Failed to initialize local notifications');
      }
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  Future<void> _fetchNotifications() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      // For testing purposes, using mock data instead of API call
      // You can replace this with your actual API call
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay

      final List<Map<String, dynamic>> mockData = [
        {
          'id': 1,
          'title': 'Welcome to ProfAcademy!',
          'body':
              'Thank you for joining our platform. Start exploring courses now.',
          'type': 'message',
          'timeAgo': '2 minutes ago',
          'isUnread': true,
        },
        {
          'id': 2,
          'title': 'New Course Available',
          'body': 'Advanced Flutter Development course is now available.',
          'type': 'message',
          'timeAgo': '1 hour ago',
          'isUnread': true,
        },
        {
          'id': 3,
          'title': 'Special Offer',
          'body': 'Get 20% off on all premium courses this week!',
          'type': 'message',
          'timeAgo': '3 hours ago',
          'isUnread': false,
        },
        {
          'id': 4,
          'title': 'System Maintenance',
          'body': 'Scheduled maintenance on Sunday at 2 AM.',
          'type': 'message',
          'timeAgo': '1 day ago',
          'isUnread': false,
        },
      ];

      setState(() {
        notifications =
            mockData.map((json) => NotificationItem.fromJson(json)).toList();
        isLoading = false;
      });

      // Show notifications for unread items
      _showNotifications();
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print('Error fetching notifications: $e');
    }
  }

  Future<void> _showNotifications() async {
    for (var notification in notifications.where((n) => n.isUnread)) {
      await _showNotification(notification);
    }
  }

  Future<void> _showNotification(NotificationItem notification) async {
    try {
      // Create notification channel for Android
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
          );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: 'notification_${notification.id}',
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  int index = 0;
  void onTap(int index) {
    setState(() {
      switch (index) {
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CorsesScreen()),
          );
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationsScreen()),
          );
          break;
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountScreen()),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customNavigationBar(index: index, onTap: onTap),
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchNotifications,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Failed to load notifications'),
            ElevatedButton(
              onPressed: _fetchNotifications,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (notifications.isEmpty) {
      return const Center(child: Text('No notifications available'));
    }

    return RefreshIndicator(
      onRefresh: _fetchNotifications,
      child: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Dismissible(
            key: Key(notification.id.toString()),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              setState(() {
                notifications.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${notification.title} dismissed')),
              );
            },
            child: ListTile(
              leading: Icon(
                _getNotificationIcon(notification.type),
                color: _getNotificationColor(notification.type),
              ),
              title: Text(
                notification.title,
                style: TextStyle(
                  fontWeight:
                      notification.isUnread
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
              subtitle: Text(notification.body),
              trailing: Text(
                notification.timeAgo,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              onTap: () {
                // Mark as read when tapped
                if (notification.isUnread) {
                  setState(() {
                    notification.isUnread = false;
                  });
                }
              },
            ),
          );
        },
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'message':
        return Icons.mail;
      case 'alert':
        return Icons.warning;
      case 'update':
        return Icons.system_update;
      case 'promotion':
        return Icons.local_offer;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'alert':
        return Colors.red;
      case 'promotion':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}

class NotificationItem {
  final int id;
  final String title;
  final String body;
  final String type;
  final String timeAgo;
  bool isUnread;

  NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.timeAgo,
    this.isUnread = true,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: json['type'] ?? 'general',
      timeAgo: json['timeAgo'] ?? 'Just now',
      isUnread: json['isUnread'] ?? true,
    );
  }
}
