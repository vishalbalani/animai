import 'package:animai/core/app/navigation/route_names.dart';
import 'package:animai/core/app/navigation/route_params.dart';
import 'package:animai/core/constants/assets/assets.dart';
import 'package:animai/core/services/localization/language_extensions.dart';
import 'package:animai/src/common/widgets/image_source_dialog.dart';
import 'package:animai/src/features/ai_models/presentation/pages/ai_models_view.dart';
import 'package:animai/src/features/home/presentation/pages/home_view.dart';
import 'package:animai/src/features/navigation/presentation/providers/navigation_provider.dart';
import 'package:animai/src/features/settings/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animai/src/features/navigation/domain/models/navigation_item.dart';
import 'package:animai/src/features/navigation/domain/models/navigation_config.dart';
import 'package:animai/src/features/navigation/presentation/widgets/custom_bottom_nav_bar.dart';

/// Application shell that manages navigation and screen states
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  /// Screen cache to prevent rebuilds
  final Map<int, Widget> _screenCache = {};

  /// Navigation configurations
  List<NavigationConfig> get _navigationConfigs => [
        NavigationConfig(
          builder: () => const HomeView(),
          item: NavigationItem(
            label: context.tr.home,
            icon: AppAssets.icon.home,
            selectedIcon: AppAssets.icon.homeSelected,
            semanticLabel: context.tr.home,
          ),
        ),
        NavigationConfig(
          builder: () => const AiModelsView(),
          item: NavigationItem(
            label: context.tr.aiModels,
            icon: AppAssets.icon.models,
            selectedIcon: AppAssets.icon.modelsSelected,
            semanticLabel: context.tr.aiModels,
          ),
        ),
        NavigationConfig(
          builder: () => const ProjectsScreen(),
          item: NavigationItem(
            label: context.tr.projects,
            icon: AppAssets.icon.projects,
            selectedIcon: AppAssets.icon.projectsSelected,
            semanticLabel: context.tr.projects,
          ),
        ),
        NavigationConfig(
          builder: () => const SettingsView(),
          item: NavigationItem(
            label: context.tr.profile,
            icon: AppAssets.icon.profile,
            selectedIcon: AppAssets.icon.profileSelected,
            semanticLabel: context.tr.profile,
          ),
        ),
      ];

  /// Get or create screen instance with caching
  Widget _getOrCreateScreen(int index) {
    return _screenCache[index] ??= _navigationConfigs[index].builder();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navigationProvider);

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Semantics(
        excludeSemantics: true,
        child: IndexedStack(
          index: selectedIndex,
          children: List.generate(
            _navigationConfigs.length,
            (index) => Semantics(
              label: _navigationConfigs[index].item.semanticLabel,
              child: selectedIndex == index
                  ? _getOrCreateScreen(index)
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        navigationConfigs: _navigationConfigs,
        selectedIndex: selectedIndex,
        onItemSelected: _handleNavigationRequest,
      ),
    );
  }

  /// Handle navigation requests including special cases
  void _handleNavigationRequest(int index) {
    if (index == 2) {
      _handleAddButton();
      return;
    }

    final adjustedIndex = index > 2 ? index - 1 : index;
    ref.read(navigationProvider.notifier).navigate(adjustedIndex);
  }

  /// Handle add button tap with proper feedback
  void _handleAddButton() {
    HapticFeedback.mediumImpact();

    showImageSourceDialog(
      context,
      onImageSelected: (imagePath) {
        if (imagePath.isNotEmpty) {
          Navigator.of(context).pushNamed(
            AppRoutes.imageEditor,
            arguments: ImageEditorParams(imagePath: imagePath),
          );
        }
      },
    );
  }
}

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(context.tr.noProjectsYet));
  }
}
