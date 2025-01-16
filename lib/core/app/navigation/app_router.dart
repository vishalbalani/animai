import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animai/core/app/navigation/routes.dart';

/// Handles platform-specific page transitions
// class AdaptivePageRoute<T> extends PageRoute<T> {
//   final WidgetBuilder builder;

//   AdaptivePageRoute({
//     required this.builder,
//     required RouteSettings settings,
//   }) : super(settings: settings);

//   @override
//   bool get maintainState => true;

//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 300);

//   @override
//   Color? get barrierColor => null;

//   @override
//   String? get barrierLabel => null;

//   @override
//   Widget buildPage(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//   ) {
//     return builder(context);
//   }

//   @override
//   Widget buildTransitions(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) =>
//       Platform.isIOS
//           ? _buildIOSTransition(animation, secondaryAnimation, child)
//           : _buildAndroidTransition(animation, child);

//   Widget _buildIOSTransition(
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     return CupertinoPageTransition(
//       primaryRouteAnimation: animation,
//       secondaryRouteAnimation: secondaryAnimation,
//       linearTransition: false,
//       child: child,
//     );
//   }

//   Widget _buildAndroidTransition(Animation<double> animation, Widget child) {
//     return SlideTransition(
//       position: animation.drive(
//         Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
//             .chain(CurveTween(curve: Curves.easeInOutCubic)),
//       ),
//       child: child,
//     );
//   }
// }

/// Generates routes with transitions and performance efficiency
Route<dynamic> generateRoute(RouteSettings settings) {
  final builder = appRoutes[settings.name];

  if (builder != null) {
    return CupertinoPageRoute(
      builder: (context) => builder(context),
      settings: settings,
    );
  }

  // 404 Page
  return CupertinoPageRoute(
    builder: (context) => const Scaffold(
      body: Center(child: Text('404 Not Found')),
    ),
  );
}

/// 404 page for undefined routes
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '404 - Page Not Found',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
