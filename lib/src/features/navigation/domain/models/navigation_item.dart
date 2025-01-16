/// Model representing a navigation item's configuration
class NavigationItem {
  final String label;
  final String icon;
  final String selectedIcon;
  final String semanticLabel;

  const NavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    String? semanticLabel,
  }) : semanticLabel = semanticLabel ?? label;
}
