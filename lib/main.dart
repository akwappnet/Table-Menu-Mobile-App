import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/repository/auth_repository.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/constants/constants_text.dart';
import 'package:table_menu_customer/utils/helpers.dart';
import 'package:table_menu_customer/utils/routes/routes.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/view/home_screen.dart';
import 'package:table_menu_customer/view/login_screen.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';
import 'package:table_menu_customer/view_model/cart_provider.dart';
import 'package:table_menu_customer/view_model/connectivity_provider.dart';
import 'package:table_menu_customer/view_model/menu_provider.dart';
import 'package:table_menu_customer/view_model/nav_provider.dart';
import 'package:table_menu_customer/view_model/notification_provider.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';
import 'package:table_menu_customer/view_model/qr_provider.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  log('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Stripe.publishableKey = stripePublishableKey;
  await dotenv.load(fileName: "assets/.env");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  NetworkApiService().setupInterceptors();
  final AuthRepository authRepository = AuthRepository();
  String loggedIn = await authRepository.isLoggedIn();
  runApp(MyApp(
    loggedIn: loggedIn,
  ));
}

/// push notification configuration

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
    enableLights: true,
    enableVibration: true,
    showBadge: true,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.loggedIn});

  final String loggedIn;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.purple,
                enableLights: true,
                enableVibration: true,
                importance: Importance.high,
                playSound: true,
                ledOnMs: 1,
                ledOffMs: 2,
                ledColor: Colors.green,
                priority: Priority.high,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
                channelShowBadge: true,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        showDialog(
            // context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            },
            context: context);
      }
    });

    getToken();
  }

  late String token;

  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => MenuProvider()),
          ChangeNotifierProvider(create: (_) => NavProvider()),
          ChangeNotifierProvider(create: (_) => QRProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
          ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ],
        child: MaterialApp(
          title: 'Table Menu Customer',
          theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.purple,
              fontFamily: 'Roboto'),
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
            nextRoute: widget.loggedIn != ''
                ? RoutesName.HOME_SCREEN_ROUTE
                : RoutesName.LOGIN_SCREEN_ROUTE,
            duration: 3000,
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.white,
            animationDuration: const Duration(seconds: 1),
            splashIconSize: 300,
            splash: Center(
              child: Image.asset(
                AssetsUtils.ASSETS_TABLE_MENU_LOGO,
                height: 300,
                width: 300,
              ),
            ),
            nextScreen:
                widget.loggedIn != '' ? const HomeScreen() : LoginScreen(),
          ),
          onGenerateRoute: Routes.generateRoute,
          navigatorKey: AppContext.navigatorKey
        ),
    );
  }
}
