import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/links.dart';
import 'package:animai/core/constants/text_styles.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/core/services/localization/language_service.dart';
import 'package:animai/core/services/localization/languages.dart';
import 'package:animai/core/utils/shimmer_utils.dart';
import 'package:animai/core/utils/toast_utils.dart';
import 'package:animai/core/utils/url_utils.dart';
import 'package:animai/core/utils/version_utils.dart';
import 'package:animai/src/features/settings/presentation/widgets/drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SettingOptions extends ConsumerStatefulWidget {
  const SettingOptions({super.key});

  @override
  ConsumerState<SettingOptions> createState() => _SettingOptionsState();
}

class _SettingOptionsState extends ConsumerState<SettingOptions> {
  List<SettingItem> _itemsBeforeDivider = [];
  List<SettingItem> _itemsAfterDivider = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize items here where context is safely available
    _itemsBeforeDivider = [
      SettingItem(
        icon: AppAssets.icon.bell,
        title: context.tr.notification,
        onTap: () {
          CustomToast.showToast(
            context: context,
            title: "Notification",
            description: "This feature is comming soon",
            type: ToastType.info,
          );
        },
      ),
      SettingItem(
        icon: AppAssets.icon.globe,
        title: context.tr.language,
        subtitle: AppLanguage.fromCode(context.currentLocale.languageCode)
            .localizedName,
        onTap: () => _showLanguageBottomSheet(context),
      ),
      SettingItem(
        icon: AppAssets.icon.share1,
        title: context.tr.shareApp,
        onTap: () {
          // TODO: Implement share functionality
        },
      ),
      SettingItem(
        icon: AppAssets.icon.star,
        title: context.tr.rateUs,
        onTap: () {},
      ),
    ];
    _itemsAfterDivider = [
      SettingItem(
        icon: AppAssets.icon.shield,
        title: context.tr.privacyPolicy,
        onTap: () {
          UrlUtils.launch(Links.privacyPolicy, context);
        },
      ),
      SettingItem(
        icon: AppAssets.icon.mobile,
        title: context.tr.version,
        isVersion: true,
        onTap: () {},
      ),
    ];
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => AnimatedBottomSheet(
        child: DropdownContent(
          label: context.tr.languages,
          items: AppLanguage.values
              .map(
                (e) => DropdownItemsModel(
                  id: e.code,
                  value: e.localizedName,
                ),
              )
              .toList(),
          selectedFromDropDown: (value) {
            if (value != null) {
              ref.read(LanguageService.provider.notifier).setLanguage(value);
            }
          },
          selectedItem:
              AppLanguage.fromCode(context.currentLocale.languageCode).code,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._itemsBeforeDivider.map((item) => _buildAnimatedSettingItem(item)),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: const Divider(
            color: AppColors.charcoal,
            height: 1,
          ),
        ),
        ..._itemsAfterDivider.map((item) => _buildAnimatedSettingItem(item)),
      ],
    );
  }

  Widget _buildAnimatedSettingItem(SettingItem item) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(item.title),
      duration: const Duration(milliseconds: 200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: _buildSettingItemWidget(item),
    );
  }

  Widget _buildSettingItemWidget(SettingItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            children: [
              SvgPicture.asset(
                item.icon,
                height: 20.h,
                // Add error builder for SVG
                placeholderBuilder: (context) => SizedBox(
                  height: 20.h,
                  width: 20.h,
                ),
              ),
              Gap(AppPadding.horizontalPadding.w),
              Expanded(
                child: Text(
                  item.title,
                  style: getTextStyle(
                    color: AppColors.white,
                    fp: FontSize.f16,
                  ),
                ),
              ),
              if (item.subtitle != null)
                Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: Text(
                    item.subtitle!,
                    style: getTextStyle(
                      color: AppColors.sunflowerYellow,
                      height: 1,
                    ),
                  ),
                ),
              _buildTrailingIcon(item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrailingIcon(SettingItem item) {
    if (item.isVersion) {
      return _buildAppVersion();
    }
    return RotatedBox(
      quarterTurns: context.isRTL ? 0 : 2,
      child: SvgPicture.asset(
        AppAssets.icon.back,
        colorFilter: const ColorFilter.mode(
          AppColors.sunflowerYellow,
          BlendMode.srcIn,
        ),
        height: 18.h,
      ),
    );
  }

  Widget _buildAppVersion() {
    return FutureBuilder<String>(
      future: AppVersionUtil.getVersion(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            "X.X.X",
            style: getTextStyle(
              color: AppColors.quickSilver,
              fp: 14,
              letterSpacing: 1.2,
              height: 1,
            ),
          ).shimmerEffect();
        }

        return Text(
          snapshot.data ?? "Error",
          style: getTextStyle(
            color: AppColors.quickSilver,
            fp: 14,
            letterSpacing: 1.2,
            height: 1,
          ),
        );
      },
    );
  }
}

// Animated bottom sheet wrapper
class AnimatedBottomSheet extends StatelessWidget {
  final Widget child;

  const AnimatedBottomSheet({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 200 * value),
          child: child,
        );
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: child,
          ),
        ),
      ),
    );
  }
}

class SettingItem {
  final String icon;
  final String title;
  final String? subtitle;
  final bool isVersion;
  final VoidCallback onTap;

  const SettingItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.isVersion = false,
    required this.onTap,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingItem &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          title == other.title &&
          subtitle == other.subtitle &&
          isVersion == other.isVersion;

  @override
  int get hashCode =>
      icon.hashCode ^ title.hashCode ^ subtitle.hashCode ^ isVersion.hashCode;
}
