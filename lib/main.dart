import 'package:animai/core/app/app.dart';
import 'package:animai/core/app/di/di.dart';
import 'package:animai/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:animai/src/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Entry point of the AnimAI application
/// Initializes necessary configurations and runs the app
void main() async {
  // Ensure Flutter bindings are initialized before calling native code
  // This is required when using platform channels or native APIs
  WidgetsFlutterBinding.ensureInitialized();

  await initAppModule();

  // Lock the app to portrait orientation only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // Initialize the app with Riverpod state management wrapper
    // ProviderScope: Required for Riverpod to manage app-wide state
    runApp(
      ProviderScope(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<SubscriptionBloc>()),
            BlocProvider(create: (_) => sl<SplashBloc>()),
          ],
          child: MyApp.instance,
        ),
      ),
    );
  });
}
