import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:go_shop/controllers/products_controller.dart';
import 'package:go_shop/features/auth_feature/login.dart';
import 'package:go_shop/features/route_feature/route_shell.dart';
import 'package:go_shop/ui/pages/reusables/cart.dart';
import 'package:go_shop/ui/pages/stand_alone/address.dart';
import 'package:go_shop/ui/pages/stand_alone/order_list_page.dart';
import 'package:go_shop/ui/pages/stand_alone/order_page.dart';
import 'package:go_shop/ui/pages/stand_alone/user_address.dart';
import 'package:go_shop/ui/pages/stand_alone/wishlist_items.dart';
import 'package:go_shop/ui/screens/account_page.dart';
import 'package:go_shop/ui/screens/categories.dart';
import 'package:go_shop/ui/screens/hot_sales.dart';
import 'package:go_shop/ui/screens/landing_page.dart';
import 'package:go_shop/ui/widgets/search_page.dart';

import '../../ui/pages/stand_alone/order_detail_page.dart';
import '../auth_feature/register.dart';

// AppRouter handles all app navigation using GoRouter
class AppRouter {
  final controller = Get.put(ProductsController());
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
          ),
          // Categories page route
          GoRoute(path: '/category', builder: (context, state) => Categories()),
          GoRoute(
            path: '/wishlist',
            builder: (context, state) => WishlistItems(),
          ),
          // Hot sales/featured products route
          GoRoute(
            path: '/featuredproducts',
            builder: (context, state) => HotSales(),
          ),
          //Search page
                    GoRoute(
            path: '/search-page',
            builder: (context, state) => SearchPage(),
          ),
          // Account page route
          GoRoute(
            path: '/accountpage',
            builder: (context, state) => AccountPage(),
          ),
          GoRoute(path: '/loginpage', builder: (context, state) => Login()),
          GoRoute(
            path: '/registerpage',
            builder: (context, state) => Register(),
          ),
          GoRoute(path: '/cartpage', builder: (context, state) => Cart()),
          GoRoute(path: '/orderpage', builder: (context, state) => OrderPage()),
          GoRoute(
            path: '/orderspage',
            builder: (context, state) => OrdersListPage(),
          ),
          GoRoute(
            path: '/orderdetails/:id',
            builder: (context, state) {
              final orderId = state.pathParameters['id']!;
              return OrderDetailsPage(orderId: orderId);
            },
          ),

          GoRoute(
            path: '/addresslistpage',
            builder: (context, state) => AddressListView(),
            routes: [
              GoRoute(
                path: 'addresspage',
                builder: (context, state) => AddAddressPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
