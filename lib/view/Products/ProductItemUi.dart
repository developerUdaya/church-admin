
// previous product ui code i just refer alignment

/*import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ikiaadmin/CustomColors.dart';
import 'package:ikiaadmin/Widgets/Productitem_Widget.dart';


class ProductitemUi extends StatefulWidget {
  const ProductitemUi({super.key});

  @override
  State<ProductitemUi> createState() => _ProductitemUiState();
}

class _ProductitemUiState extends State<ProductitemUi> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e){
        setState(() {
          isHover = true;
        });
      },
      onExit: (e){
        setState(() {
          isHover = false;
        });
      },
      child: SizedBox(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Stack(
            children: [
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductItemWidget(images: listofImage,),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ProductDetailsWidget(
                    productName: 'Product',
                    price: 285,
                    originalPrice: 345,
                    rating: 3,
                    isHover:isHover,
                  ),
                ),
              ],
            ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.06,
                right: MediaQuery.of(context).size.width * 0.02,
                child: const Cart(),
              )
          ],
          ),
        ),
      ),
    );
  }
}

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Tooltip(
            message: 'Add to cart',
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            preferBelow: false,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.deepPurple,
              child: Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedShoppingBasket02,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class ProductDetailsWidget extends StatelessWidget {
  final String productName;
  final double price;
  final double originalPrice;
  final int rating;
  final  bool isHover;

  const ProductDetailsWidget({
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
            fontSize: 19,
            color: isHover? Colors.deepPurpleAccent : Colors.black,
          ),
        ),
        Row(
          children: [
            Text(
              '\u{0024}$price',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '\u{0024}$originalPrice',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
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

class StarRating extends StatelessWidget {
  final int rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
            (index) => Icon(
          HugeIcons.strokeRoundedStar,
          color: index < rating ? Colors.yellow : Colors.black54,
          size: 16,
        ),
      ),
    );
  }
}*/
