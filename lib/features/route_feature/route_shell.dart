import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteShell extends StatelessWidget {
  final Widget child;
  const RouteShell({super.key, required this.child});

  static const destinations = [
    {'label': 'Shop', 'icon': Icons.home, 'route': '/landingpage'},
    {'label': 'Category', 'icon': Icons.category, 'route': '/category'},
    {
      'label': 'Hot Sales',
      'icon': Icons.trending_up_sharp,
      'route': '/featuredproducts',
    },
    {
      'label': 'Account',
      'icon': Icons.account_circle_sharp,
      'route': '/accountpage',
    },
  ];

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return destinations.indexWhere(
      (d) => location.startsWith(d['route'] as String),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: selectedIndex < 0 ? 0 : selectedIndex,
        onTap: (index) {
          final route = destinations[index]['route'] as String;
          if (GoRouterState.of(context).uri.toString() != route) {
            context.go(route);
          }
        },
        items: [
          for (var item in destinations)
            BottomNavigationBarItem(
              icon: Icon(item['icon'] as IconData),
              label: item['label'] as String,
            ),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
