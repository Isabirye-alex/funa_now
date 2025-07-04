import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemBuilder: (context, index) => Container(
          width: MediaQuery.of(context).size.width * 0.70,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.blue[700],
            image: DecorationImage(
              image: NetworkImage(
                "https://res.cloudinary.com/doxivkfxr/image/upload/v1751547241/products/aelysxt8osxxbsxamhts.jpg",
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(20),
                BlendMode.darken,
              ),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Big Summer Sale!\nUp to 50% OFF",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,

                  shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
