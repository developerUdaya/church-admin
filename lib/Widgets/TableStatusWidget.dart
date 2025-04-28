import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class Status_Widget extends StatelessWidget {
  final String status;
  final Map<String, Color> statusColors;

  const Status_Widget({
    Key? key,
    required this.status,
    required this.statusColors,
  });


  @override
  Widget build(BuildContext context) {
    final Color baseColor = statusColors[status] ?? Colors.grey;
    final Color backgroundColor = baseColor.withOpacity(0.2);
    final Color textColor = baseColor;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(4.5),
            ),
            child: Text(
                status,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
            ),
          ),
        ],
      ),
    );

  }
}



class PaymentStatus extends StatelessWidget {
  final String status;


  final Map<String, Color> statusColors = {
    'upi': Colors.purple,
    'cash': Colors.deepOrangeAccent,
    'card': Colors.lightGreen,
  };

  final Map<String, IconData> statusIcons = {
    'upi': HugeIcons.strokeRoundedPayment01,
    'cash': HugeIcons.strokeRoundedCash01,
    'card': HugeIcons.strokeRoundedCreditCard,
  };

  PaymentStatus({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final Color baseColor = statusColors[status] ?? Colors.grey;
    final Color backgroundColor = baseColor.withOpacity(0.2);
    final Color textColor = baseColor;
    final IconData? icon = statusIcons[status];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
             HugeIcon(
              color: textColor,
              size: 16.0, icon: icon,
            ),
          const SizedBox(width: 4.0),
          Text(
            status,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

