import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class DashboardHeader extends StatelessWidget{
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  Function? onMenuPressed;

  DashboardHeader({
    super.key,
    this.title = 'Dashboard',
    this.actions,
    this.leading,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Row(
              children: [
                IconButton(
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedMenu11,
                      color: Colors.black54,
                      size: 18.0,
                    ),
                    onPressed: () {
                      onMenuPressed!();

                    },
                  ),
                IconButton(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedSearch01,
                    color: Colors.black54,
                    size: 18.0,
                  ),
                  onPressed: () {},
                ),

              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedMoon02,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedNotification03,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: HugeIcon(
                    icon: HugeIcons.strokeRoundedLanguageSquare,
                    color: Colors.black,
                    size: 18.0,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 8),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage('assets/ProfileImage2.jpeg'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child:  IconButton(
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedArrowDown01,
                          color: Colors.black,
                          size: 18.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}


/*AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          // Notification Icon
          IconButton(
            icon:  HugeIcon(color: Colors.black54, icon:HugeIcons.strokeRoundedMoon02,),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
          IconButton(
            icon: HugeIcon(icon:HugeIcons.strokeRoundedNotification02, color: Colors.black54),
            onPressed: () {
              // Handle language selection
            },
          ),
          IconButton(
            icon: HugeIcon(icon:HugeIcons.strokeRoundedLanguageCircle, color: Colors.black54),
            onPressed: () {
              // Handle language selection
            },
          ),
          // User profile icon/image
          IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedUser, color: Colors.black54),
            onPressed: () {
              // Handle user profile action
            },
          ),
        ],
      )*/