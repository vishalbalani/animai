// lib/src/features/splash/presentation/pages/splash_view.dart
import 'package:animai/core/app/navigation/route_names.dart';
import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/utils/permission_utils.dart';
import 'package:animai/src/features/splash/data/models/splash_state.dart';
import 'package:animai/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:animai/src/features/splash/presentation/widgets/splash_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/// The main splash screen widget that handles initialization and navigation
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    _splashBloc = context.read<SplashBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeSplash();
    });
  }

  Future<void> _initializeSplash() async {
    // Handle notification permissions
    await PermissionUtils.handleNotificationPermission(context);

    // Add artificial delay for branding visibility
    // TODO: Consider removing delay in production if not required
    await Future.delayed(const Duration(seconds: 1));

    await _splashBloc.checkUserSubscription();
  }

  void _handleNavigation(SplashState state) {
    switch (state) {
      case SplashState.authenticated:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.appShell,
          (route) => false,
        );
      case SplashState.unauthenticated:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.subscriptionPlans,
          (route) => false,
        );
      case SplashState.error:
        // TODO: Implement error handling
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) => _handleNavigation(state),
      child: Scaffold(
        body: Stack(
          children: [
            const SplashBackground(),
            Center(
              child: SvgPicture.asset(
                AppAssets.svg.logo,
                height: 100.h,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
