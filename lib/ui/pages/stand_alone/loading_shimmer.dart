import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LandingPageShimmer extends StatefulWidget {
  const LandingPageShimmer({super.key});

  @override
  State<LandingPageShimmer> createState() => _LandingPageShimmerState();
}

class _LandingPageShimmerState extends State<LandingPageShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulse = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: const Color.fromARGB(255, 193, 218, 238),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                children: List.generate(1, (index) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 16,
                                width: double.infinity,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 14,
                                width: 150,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 14,
                                width: 100,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: FadeTransition(
              opacity: _pulse,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.hourglass_top,
                    size: 48,
                    color: Colors.purpleAccent,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Hang tight! We're loading your experience...",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.purpleAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
