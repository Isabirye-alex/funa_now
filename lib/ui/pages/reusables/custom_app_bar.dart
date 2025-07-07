import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.hint,
    required this.icon,
    this.icon2,
    this.iconText,
    this.iconText2,
    this.color,
    this.onTap1,
    this.onTap2
  });
  final String? hint;
  final IconData icon;
  final IconData? icon2;
  final String? iconText;
  final String? iconText2;
  final Color? color;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: InkWell(
                onTap: onTap1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Icon(icon2, color: color),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          iconText2 ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(10),
                child: SearchBar(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  leading: Icon(Icons.search, color: Colors.black),
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                  onTap: () {},
                  onTapOutside: (event) {},
                  hintText: hint,
                  hintStyle: WidgetStateTextStyle.resolveWith(
                    (states) => TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  elevation: WidgetStateProperty.all(2.0),
                  backgroundColor: WidgetStateColor.resolveWith(
                    (states) => Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: onTap2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Icon(icon),
                      Text(
                        iconText ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
      ],
    );
  }
}
