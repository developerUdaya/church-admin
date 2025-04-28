import 'package:flutter/material.dart';

class UsernameWidget extends StatelessWidget {
  final String username;
  final String profilePictures;

  UsernameWidget({required this.username, required this.profilePictures});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: NetworkImage(profilePictures),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            username,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
