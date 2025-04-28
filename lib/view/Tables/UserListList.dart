import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final List<String> userImages;

  const UserList({required this.userImages});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 80,
        height: 80,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              userImages.length,
                  (index) => Transform.translate(
                offset: Offset(-8.0 * index, 0),
                child:Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      image: NetworkImage(userImages[index]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Color(0xFFFFFFFF),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



/* Align(
                  widthFactor: 0.91,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userImages[index]),
                      radius: 20,
                    ),
                  ),
                )*/
