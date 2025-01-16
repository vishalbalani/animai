import 'package:animai/core/app/navigation/route_names.dart';
import 'package:animai/core/constants/gradients.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/core/utils/toast_utils.dart';
import 'package:animai/src/common/widgets/gradient_button.dart';
import 'package:animai/src/features/navigation/presentation/providers/navigation_provider.dart';
import 'package:animai/src/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:animai/src/features/subscription/presentation/widget/detailed_plan_widget.dart';
import 'package:animai/src/features/subscription/presentation/widget/subscription_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// View responsible for displaying the subscription purchase screen.
/// Implements responsive layout, animations, and accessibility features.
class SubscriptionPurchaseView extends ConsumerWidget {
  const SubscriptionPurchaseView({super.key});

  // Define breakpoints for responsive design
  static const double _tabletBreakpoint = 768;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get screen size for responsive calculations
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= _tabletBreakpoint;

    return Scaffold(
      body: SafeArea(
        child: Semantics(
          label: context.tr.subscriptionPurchaseScreen,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Gap(16.h),
                  _buildHeader(context),
                  _buildMainContent(isTablet),
                  _buildSubscribeButton(context, ref),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds the header section with back button and title
  Widget _buildHeader(BuildContext context) {
    return Semantics(
      header: true,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding.w),
        child: const SubscriptionHeader(),
      ),
    );
  }

  /// Builds the main scrollable content with responsive layout
  Widget _buildMainContent(bool isTablet) {
    return Expanded(
      child: Stack(
        children: [
          // Decorative gradient circle in background
          _buildBackgroundGradient(),

          // Main subscription panel with responsive padding
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet
                  ? (AppPadding.horizontalPadding * 1.5).w
                  : AppPadding.horizontalPadding.w,
            ),
            child: Column(
              children: [
                Gap(72.h),
                // Using Hero for smooth transitions between screens
                const MergeSemantics(
                  child: DetailedPlanWidget(),
                ),
                Gap(20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the decorative gradient circle in the background
  Widget _buildBackgroundGradient() {
    return Positioned(
      top: 35.h,
      left: 0,
      right: 0,
      child: RepaintBoundary(
        child: Semantics(
          excludeSemantics: true, // Exclude decorative elements
          child: Container(
            width: 227.w,
            height: 227.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: Gradients.circularRainbow,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the subscribe button with loading state and navigation handling
  Widget _buildSubscribeButton(BuildContext context, WidgetRef ref) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: () {
            // Announce success to screen readers
            SemanticsService.announce(
              context.tr.subscriptionPurchaseSuccess,
              TextDirection.ltr,
            );

            ref.read(navigationProvider.notifier).navigate(0);
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.appShell,
                (route) => false,
              );
            }
          },
          error: (message) {
            // Show error message with accessibility support
            CustomToast.showToast(
              context: context,
              title: "Error",
              description: message,
              type: ToastType.error,
            );
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );

        return Padding(
          padding: EdgeInsets.only(
            left: AppPadding.horizontalPadding.w,
            right: AppPadding.horizontalPadding.w,
            bottom: 27.h,
          ),
          child: Focus(
            autofocus: true, // Main action gets initial focus
            child: Semantics(
              button: true,
              enabled: !isLoading,
              label: isLoading
                  ? context.tr.processingSubscription
                  : context.tr.subscribeNow,
              child: GradientButton(
                isLoading: isLoading,
                text: context.tr.subscribeNow,
                onTap: () {
                  HapticFeedback.mediumImpact(); // Provide tactile feedback
                  context.read<SubscriptionBloc>().add(
                        const SubscriptionEvent.purchaseSubscription("1.99"),
                      );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
