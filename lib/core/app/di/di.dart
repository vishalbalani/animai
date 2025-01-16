import 'package:animai/core/services/local_storage/shared_pref.dart';
import 'package:animai/core/services/notifications/notification_service.dart';
import 'package:animai/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:animai/src/features/subscription/data/repositories/subscription_repository_impl.dart';
import 'package:animai/src/features/subscription/domain/subscription_repository.dart';
import 'package:animai/src/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'di.main.dart';
