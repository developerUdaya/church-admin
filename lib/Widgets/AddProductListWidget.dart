import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AddProductTittleBar extends StatelessWidget {
  final String titleName;
  final double WithSize;
  final VoidCallback? onPressed;
  final isHideAddButton;

  const AddProductTittleBar({super.key,required this.titleName, this.WithSize =0.61,this.onPressed, this.isHideAddButton= false});

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Color(0xFF7876FA);

    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 100),
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width > 1200
              ? 1200
              : MediaQuery.of(context).size.width < 600
                ? 600
                : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              // Title Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                child: Text(
                  titleName,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if(!isHideAddButton)Row(
                children: [
                     Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedHome02,
                        color: Colors.black54,
                        size: 20.0,
                      ),
                    ),
                  GestureDetector(
                    onTap: onPressed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 11,
                      ),
                      decoration: BoxDecoration(
                        color: baseColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Add"+titleName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:FontWeight.w600,
                          color: baseColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

