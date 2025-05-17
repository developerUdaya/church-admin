import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final List<String> userImages;
  final int count;

  const UserList({required this.userImages, required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 80,
      // height: 80,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            count,
            (index) => Transform.translate(
            offset: Offset(-20.0 * index, 0),
            child: Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 251, 251, 251),
                image: index < userImages.length && userImages[index].isNotEmpty
              ? DecorationImage(
                  image: NetworkImage('${userImages[index]}'),
                  fit: BoxFit.cover,
                ): null,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all( color: const Color(0xff7c94b6), width: 0.5, ),
              ),
              child: index >= userImages.length
                  ? Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(color: const Color(0xff7c94b6), fontSize: 12),
                ),
              ): null,
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
