import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    const int productsCount = 20;
    const int chunkSize = 4;

    List<Widget> slivers = [];
    int rendered = 0;

    while (rendered < productsCount) {
      // Add grid chunk
      final int end = (rendered + chunkSize > productsCount)
          ? productsCount
          : rendered + chunkSize;
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 12),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              final productIndex = rendered + index;
              return Container(
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
                child: Stack(
                  children: [
                    // Discount label at the top left
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withAlpha(200),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '20% OFF',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    // Favorite icon at the top right
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.favorite_border, color: Colors.red),
                          onPressed: () {},
                          iconSize: 22,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                      ),
                    ),
                    // Price and product name at the bottom left
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product ${productIndex + 1}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(color: Colors.black45, blurRadius: 4),
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "\$${(20 + productIndex * 5)}",
                              style: TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(color: Colors.black45, blurRadius: 4),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: end - rendered),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              mainAxisExtent: 130,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 4 / 4,
            ),
          ),
        ),
      );

      rendered = end;

      // Add heading after each chunk, except after the last
      if (rendered < productsCount) {
        slivers.add(
          SliverToBoxAdapter(
            child: Container(
              // margin: EdgeInsets.only(top: 8, bottom: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Curated For You",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        );
      }
    }

    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      slivers: slivers,
    );
  }
}
