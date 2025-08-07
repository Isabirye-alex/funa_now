import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_shop/features/route_feature/app_router.dart';

class ConnectionChecker extends StatefulWidget {
  const ConnectionChecker({super.key});

  @override
  State<ConnectionChecker> createState() => _ConnectionCheckerState();
}

class _ConnectionCheckerState extends State<ConnectionChecker> {
  bool _isConnected = true;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _checkInternet();
    _subscription = Connectivity().onConnectivityChanged.listen(
      (_) => _checkInternet(),
    );
  }

  Future<void> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      final connected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      setState(() => _isConnected = connected);
    } on SocketException {
      setState(() => _isConnected = false);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Use your design's base size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return _isConnected
            ? MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'X-Store',
                theme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: const Color(0xFF1976D2),
                  cardColor: const Color(0xFF2A2D3E),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF1C1C2D),
                    elevation: 10,
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                routerConfig: AppRouter.router,
              )
            : MaterialApp(
                debugShowCheckedModeBanner: false,
                home: NoInternetScreen(onRetry: _checkInternet),
              );
      },
    );
  }
}

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.red),
              const SizedBox(height: 20),
              const Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 22, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Please check your network and try again.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
