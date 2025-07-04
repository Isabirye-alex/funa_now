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
      routerConfig: AppRouter.router,
    );
  }
}