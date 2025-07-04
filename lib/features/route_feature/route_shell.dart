import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteShell extends StatelessWidget {
  final Widget child;
  const RouteShell({super.key, required this.child});

  static const destinations = [
    {'label': 'Landing Page', 'icon': Icons.home, 'route': '/landingpage'},
    // Add more destinations as needed
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
      appBar: AppBar(
        title: const Text("Easy Mall DashBoard"),
        backgroundColor: Colors.black45,
        centerTitle: true,
        actions: const [Icon(Icons.account_circle)],
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
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
