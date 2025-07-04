import 'package:go_router/go_router.dart';
import 'package:go_shop/features/route_feature/route_shell.dart';
import 'package:go_shop/ui/screens/account_page.dart';
import 'package:go_shop/ui/screens/categories.dart';
import 'package:go_shop/ui/screens/featured_products.dart';
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
          GoRoute(path: '/category', builder: (context, state) => Categories()),
          GoRoute(path: '/featuredproducts', builder: (context, state) => FeaturedProducts()),
          GoRoute(path: '/accountpage', builder: (context, state) => AccountPage()),
        ],
      ),
    ],
  );
}
