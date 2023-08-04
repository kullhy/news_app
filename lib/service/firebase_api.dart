import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:learn_bloc_2/main.dart';
import 'package:learn_bloc_2/navigator/app_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/noti/noti_bloc.dart';
import '../bloc/noti/noti_event.dart';
import '../models/news/article.dart';
import '../navigator/routes.dart';
import '../pages/home/components/home_header_widget.dart';
import 'fetch_news_data.dart';

class FireBaseApi {
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'high_importance_Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> sendNotification() async {
    try {
      // Lấy token thiết bị
      String? token = await _firebaseMessaging.getToken();
      log("$token");
      // Kiểm tra xem token có tồn tại không
      if (1 > 0) {
        // Gửi yêu cầu gửi thông báo đến token thiết bị
        await _firebaseMessaging.sendMessage(
          to: "cHaX3pGZRDSGoYFhF88v01:APA91bGGaZtvjqwfTh8qQG756oVLpPeqblUoPEF9N7xnTJDK4N6MKifkKZUm0XuAory1_K8LZyVIy0Xl6lWD3ksq9BUkGHm5wvZX5x_LCrbO9FSULOtJpClCVJIU7p2YfXSq5Qsrecea",
          // data: {
          //   'title': 'Tiêu đề thông báo',
          //   'body': 'Nội dung thông báo',
          // },
          messageId: "messageId",
        );
        log('Đã gửi yêu cầu gửi thông báo thành công!');
      } else {
        log('Không tìm thấy token thiết bị!');
      }
    } catch (e) {
      log('Lỗi khi gửi yêu cầu gửi thông báo: $e');
    }
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log("token = $fCMToken ");
    initPushNotifications();
    try {
      initLocalNotifications();
    } catch (e) {
      log("$e");
    }
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNoti', true);
    if (contextx != null) {
      contextx?.read<NotiBloc>().add((SetNotiEvent()));
    } else {
      log("no context");
      return;
    }
    // // ignore: unnecessary_null_comparison
    // if (message == null) return;
    // final List<Article> listArticle = await fetchHeadline();
    // AppNavigator.push(Routes.detailPage, arguments: listArticle[0]);
    // isNoti = false;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('isNoti', false);
    // if (contextx != null) {
    //   contextx?.read<NotiBloc>().add((SetNotiEvent()));
    // } else {
    //   return;
    // }
  }

  void handleMessage(RemoteMessage? message) async {
    // ignore: unnecessary_null_comparison
    if (message == null) return;
    final List<Article> listArticle = await fetchHeadline();
    AppNavigator.push(Routes.detailPage, arguments: listArticle[0]);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isNoti', false);
    if (contextx != null) {
      contextx?.read<NotiBloc>().add((SetNotiEvent()));
    } else {
      return;
    }
  }

  Future initLocalNotifications() async {
    // const iOS = IOSInitializationSettings();
    const android =
        AndroidInitializationSettings('@drawable/launch_background');
    const settings = InitializationSettings(android: android, iOS: null);
    await FlutterLocalNotificationsPlugin().initialize(
      settings,
      onSelectNotification: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload!));
        handleMessage(message);
      },
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isNoti', true);
      if (contextx != null) {
        contextx?.read<NotiBloc>().add((SetNotiEvent()));
      } else {
        return;
      }
      log(message.notification!.title!);
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/launch_background',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }
}
