import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:flutter/material.dart';


//main Product Ui Class

class ProductItemWidget extends StatefulWidget {
  final String productName;
  final double price;
  final double originalPrice;
  final int rating;
  final String images;

  const ProductItemWidget({
    super.key,
    required this.productName,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.images,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = MediaQuery.of(context).size.width;
          double screenHeight = MediaQuery.of(context).size.height;

          // Adjust sizes dynamically based on screen width
          double containerWidth = screenWidth * 0.2;
          double containerHeight = screenHeight * 0.48;
          double imageHeight = containerHeight * 0.7;

          return Stack(
            children: [
              Container(
                height: containerHeight,
                width: containerWidth,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2,
                      spreadRadius: 0.5,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: containerWidth,
                        height: imageHeight,
                        transform: Matrix4.identity()..scale(isHover ? 1.05 : 1.00),
                        transformAlignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: widget.images.isNotEmpty
                                ? NetworkImage(widget.images)
                                : const NetworkImage(''),
                          ),
                        ),
                      ),
                    ),
                    // Product Details
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductDetails(
                        productName: widget.productName,
                        price: widget.price,
                        originalPrice: widget.originalPrice,
                        rating: widget.rating,
                        isHover: isHover,
                      ),
                    ),
                  ],
                ),
              ),
              // Cart Button Positioned
              Positioned(
                bottom: containerHeight * 0.18,
                right: containerWidth * 0.1,
                child: const CartButton(),
              ),
            ],
          );
        },
      ),
    );

  }
}



// product search ui
class ProductSearch extends StatefulWidget {
  final String name;
  const ProductSearch({super.key, required this.name});

  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: Color(0xFF000000),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 200,
          height: 37,
          child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search Products",
                hintStyle: TextStyle(fontSize: 14,color: Color(0xFFABADB2)),
                prefixIcon: HugeIcon(icon: HugeIcons.strokeRoundedSearch01,size: 14,color:  Color(0xFFABADB2),),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFABADB2)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Color(0xFFABADB2)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}



//Cart Button Ui
class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Add to cart',
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.deepPurple,
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedShoppingBasket02,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}



//Product information Ui
class ProductDetails extends StatelessWidget {
  final String productName;
  final double price;
  final double originalPrice;
  final int rating;
  final bool isHover;

  const ProductDetails({
    super.key,
    required this.productName,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.isHover,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isHover ? Colors.deepPurpleAccent : Color(0xFF2E3748),
          ),
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            Text(
              '\u{0024}${price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600, color: Color(0xFF2E3748)),
            ),
            const SizedBox(width: 8),
            Text(
              '\u{0024}${originalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const Spacer(),
            StarRating(rating: rating),
          ],
        ),
      ],
    );
  }
}



//StarRating Ui
class StarRating extends StatelessWidget {
  final int rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
            (index) => HugeIcon(
          icon:HugeIcons.strokeRoundedStar,
          color: index < rating ? Colors.yellow : Colors.black54,
          size: 16,
        ),
      ),
    );
  }
}
