import 'dart:ui';

import 'package:animai/core/constants/colors.dart';
import 'package:animai/core/constants/values.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/features/navigation/domain/models/navigation_config.dart';
import 'package:animai/src/features/navigation/presentation/widgets/add_button.dart';
import 'package:animai/src/features/navigation/presentation/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom bottom navigation bar with glass effect and accessibility
class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<NavigationConfig> navigationConfigs;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemSelected,
    required this.navigationConfigs,
    super.key,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(
      widget.navigationConfigs.length + 1,
      (_) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: context.tr.navigationBar,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.horizontalPadding.w,
            vertical: 6.h,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: RepaintBoundary(
                child: _buildNavBarContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarContent() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.jet.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.gunmetal, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildNavItems(),
      ),
    );
  }

  List<Widget> _buildNavItems() {
    final items = <Widget>[];
    const centerIndex = 2;

    for (var i = 0; i < widget.navigationConfigs.length + 1; i++) {
      if (i == centerIndex) {
        items.add(
          Expanded(
            child: AddButton(
              onTap: () => widget.onItemSelected(centerIndex),
              focusNode: _focusNodes[centerIndex],
            ),
          ),
        );
      } else {
        final configIndex = i > centerIndex ? i - 1 : i;
        final config = widget.navigationConfigs[configIndex];
        items.add(
          Expanded(
            child: NavItem(
              index: i,
              item: config.item,
              isSelected: widget.selectedIndex == configIndex,
              onTap: widget.onItemSelected,
              focusNode: _focusNodes[i],
            ),
          ),
        );
      }
    }

    return items;
  }
}
