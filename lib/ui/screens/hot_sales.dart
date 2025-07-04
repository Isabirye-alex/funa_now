import 'package:flutter/material.dart';
import 'package:go_shop/ui/pages/reusables/custom_app_bar.dart';
import 'package:iconsax/iconsax.dart';

class HotSales extends StatelessWidget {
  const HotSales({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: CustomAppBar(
          icon: Iconsax.trend_up,
          hint: 'Browse Hot deals....',
          iconText: 'Hot Sales',
          icon2: Iconsax.flash_1,
          iconText2: 'New Stock',
        ),
      ),
      body: Column(),
    );
  }
}
