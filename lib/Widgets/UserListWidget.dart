import 'package:flutter/material.dart';

class UserlistWidget extends StatelessWidget {
  final String image;
  final Color colors;

  const UserlistWidget({
    super.key,
    required this.colors,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: colors,
        backgroundImage: AssetImage('$image'),
      ),
    );
  }
}

