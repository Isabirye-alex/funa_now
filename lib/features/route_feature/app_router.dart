
import 'package:go_router/go_router.dart';
import 'package:go_shop/features/route_feature/route_shell.dart';
import 'package:go_shop/ui/screens/landing_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/landingpage',
    routes: [
      ShellRoute(
        builder: (context, state, child) => RouteShell(child: child),
        routes: [
          GoRoute(
            path: '/landingpage',
            builder: (context, state) => LandingPage(),
            // routes: [
            //   GoRoute(
            //     path: 'addproduct',
            //     builder: (contex, state) => ProductUploader(),
            //   ),
            // ],
          ),
          // GoRoute(path: '/brands', builder: (context, state) => Brands()),
          // GoRoute(
          //   path: '/categories',
          //   builder: (context, state) => Categories(),
          // ),
          // GoRoute(
          //   path: '/subcategories',
          //   builder: (context, state) => Subcategories(),
          // ),
          // GoRoute(path: '/orders', builder: (context, state) => Orders()),
          // GoRoute(path: '/products', builder: (context, state) => Products()),
          // GoRoute(
          //   path: '/notifications',
          //   builder: (context, state) => Notifications(),
          // ),
          // GoRoute(path: '/vendors', builder: (context, state) => Vendors()),
          // GoRoute(path: '/users', builder: (context, state) => Users()),
          // GoRoute(path: '/feedback', builder: (context, state) => Feedback()),
          // GoRoute(path: '/logout', builder: (context, state) => Logout()),
          // GoRoute(path: '/help', builder: (context, state) => Help()),
          // GoRoute(path: '/analytics', builder: (context, state) => Analytics()),
          // GoRoute(path: '/reports', builder: (context, state) => Reports()),
          // GoRoute(path: '/settings', builder: (context, state) => Settings()),

          //Mini routes
        ],
      ),
    ],
  );
}
