import 'package:flutter/material.dart';
import 'package:go_shop/features/route_feature/app_router.dart';

void main() {
  runApp(FunaNow());
}

class FunaNow extends StatelessWidget {
  const FunaNow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeAnimationCurve: Curves.decelerate,
      title: 'Admin Dashboard',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF1976D2),
        cardColor: Color(0xFF2A2D3E),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1C1C2D),
          elevation: 10,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
