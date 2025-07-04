import 'package:go_router/go_router.dart';
import 'package:go_shop/features/route_feature/route_shell.dart';
import 'package:go_shop/ui/screens/account_page.dart';
import 'package:go_shop/ui/screens/categories.dart';
import 'package:go_shop/ui/screens/hot_sales.dart';
import 'package:go_shop/ui/screens/landing_page.dart';

// AppRouter handles all app navigation using GoRouter
class AppRouter {
  static final router = GoRouter(
    initialLocation: '/landingpage', // Default route on app start
    routes: [
      // ShellRoute provides a shared scaffold (RouteShell) for all main routes
      ShellRoute(
        builder: (context, state, child) => RouteShell(child: child),
        routes: [
          // Landing page route
          GoRoute(
            path: '/landingpage',
            builder: (context, state) => LandingPage(),
            // Example for nested routes (commented out)
            // routes: [
            //   GoRoute(
            //     path: 'addproduct',
            //     builder: (contex, state) => ProductUploader(),
            //   ),
            // ],
          ),
          // Categories page route
          GoRoute(
            path: '/category',
            builder: (context, state) => Categories(),
          ),
          // Hot sales/featured products route
          GoRoute(
            path: '/featuredproducts',
            builder: (context, state) => HotSales(),
          ),
          // Account page route
          GoRoute(
            path: '/accountpage',
            builder: (context, state) => AccountPage(),
          ),
        ],
      ),
    ],
  );
}
