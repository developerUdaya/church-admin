import 'package:flutter/material.dart';

import '../../CustomColors.dart';

class Gridimage extends StatefulWidget {
  const Gridimage({super.key});

  @override
  State<Gridimage> createState() => _GridimageState();
}

class _GridimageState extends State<Gridimage> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(34),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: gridImage.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
              crossAxisSpacing: 48,
              mainAxisSpacing: 30,
              mainAxisExtent: 350,
            ),
            itemBuilder: (context,index)
            {
              return Container(
                decoration: BoxDecoration(
                   /* color: Colors.blue,*/
                    borderRadius: BorderRadius.circular(24)
                ),

                child:  ClipRRect(
                     borderRadius: BorderRadius.circular(24),
                    child: Image.network("${gridImage.elementAt(index)['image']}",
                        fit: BoxFit.cover,
                    )
                ),
              );
            }
        ),
      );

  }
}
