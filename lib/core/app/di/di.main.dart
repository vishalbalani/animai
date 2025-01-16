part of 'di.dart';

final sl = GetIt.instance;

Future<void> initAppModule() async {
  // Secure Storage
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await NotificationServicesImpl(flutterLocalNotificationsPlugin)
      .initLocalNotifications();

  sl
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<FlutterLocalNotificationsPlugin>(
      () => flutterLocalNotificationsPlugin,
    )
    ..registerLazySingleton<SharedPref>(
      () => SharedPrefImpl(sl()),
    );

  sl.registerLazySingleton<NotificationServices>(
    () => NotificationServicesImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepositoryImpl(sl(), sl()),
  );

  // Bloc
  sl
    ..registerLazySingleton<SubscriptionBloc>(
      () => SubscriptionBloc(sl()),
    )
    ..registerLazySingleton<SplashBloc>(
      () => SplashBloc(sl()),
    );
}

void reset() {
  sl.reset();
  initAppModule();
}
