import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../Widgets/DashBoardButton.dart';
import '../../Widgets/DashboradDropDown.dart';

class SidebarUi extends StatefulWidget {
  final Function(int) onItemSelected;
  const SidebarUi({super.key,required this.onItemSelected,});

  @override
  State<SidebarUi> createState() => _SidebarUiState();
}

class _SidebarUiState extends State<SidebarUi> {
  // Tracks the currently selected item
  String selectedItem = 'Dashboard';
  final Map<String, int> pageIndexMap = {
    'Dashboard':0,
    'Reports':1,
    'User List':2,
    'Members List':3,
    'Families':4,
    'Little Flocks':5,
    'Student':6,
    'Committee':7,
    'Pastors':8,
    'Church Staff':9,
    'Department':10,
    'Membership Reports': 11,
    'Fund Management': 12,
    'Donations': 13,
    'Asset Management':14,
    'Email Communication': 15,
    'Notification': 16,
    'Blood Requirement':17,
    'Blog': 18,
    'Testimony': 19,
    'Prayers': 20,
    'Meetings':21,
    'Event Management': 22,
    'Remembrance Days': 23,
    'Notices': 24,
    'Function Hall': 25,
    'Audio Podcast': 26,
    'Gallery':27,
    'Manage Role':28,
    'Login Reports':29,
    'Zone Areas': 30,
    'Zone List': 31,
    'Zone Reports': 32,
    'Products': 33,
    'Orders': 34,
    'News Letter':35,
    'Whatsapp':36,
    'Speech':37,
    'Sms Communication':38,
        'Wishes':37,





//old data
    /*'Member Attendance': 27,
    'Student Attendance': 28,
    'Gallery': 29,
    'Manage Role': 30,
    'Login Reports': 31,
    'Zone Areas': 32,
    'Zone List': 33,
    'Zone Reports': 34,
    'Products': 35,
    'Orders': 36,
    'Consumables': 37,
    'News Letter': 38,
    'Whatsapp': 39,*/
  };
  /* final Map<String, int> pageIndexMap = {
    'Dashboard': 0,
    'Reports' : 1,
    'User List':2,
    'Members List':3,
    'Families':4,
    'Little Flocks':5,
    'Student':6,
    'Committee':7,
    'Pastors':8,
    'Church Staff':9,
    'Department':10,
    'Membership Reports': 11,
    'Membership Register': 12,
    'Fund Management': 13,
    'Donations': 14,
    'Asset Management':15,
    'Wishes':16,
    'Sms Communication':18,
    'Email Communication': 19,
    'Notification': 20,
    'Blood Requirement':21,
    'Blog': 22,
    'Social Media':23,
    'Speech':24,
    'Testimony': 25,
    'Prayers': 26,
    'Meetings':27,
    'Event Management': 28,
    'Remembrance Days': 29,
    'Notices': 30,
    'Function Hall': 31,
    'Audio Podcast': 32,
    /*'Member Attendance': 27,
    'Student Attendance': 28,
    'Gallery': 29,
    'Manage Role': 30,
    'Login Reports': 31,
    'Zone Areas': 32,
    'Zone List': 33,
    'Zone Reports': 34,
    'Products': 35,
    'Orders': 36,
    'Consumables': 37,
    'News Letter': 38,
    'Whatsapp': 39,*/
  };*/

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.3, horizontal: 12.2),
        // margin: const EdgeInsets.symmetric(vertical: 14.3, horizontal: 12.2),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  'IKIA Church',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            DashboardButton(
              icon: HugeIcons.strokeRoundedHome06,
              label: 'Dashboard',
              isSelected: selectedItem == 'Dashboard',
              onPressed: (item) => setState(() {
                selectedItem = 'Dashboard';
                if (pageIndexMap.containsKey(item)) {
                   widget.onItemSelected(pageIndexMap[item]!);
                }
              }),
            ),

            // DashboardButton(
            //   icon: HugeIcons.strokeRoundedAnalyticsUp,
            //   label: 'Reports',
            //   isSelected: selectedItem == 'Reports',
            //   onPressed: (item) => setState(() {
            //     selectedItem = 'Reports';
            //     if (pageIndexMap.containsKey(item)) {
            //       print('select value $item');
            //       widget.onItemSelected(pageIndexMap[item]!);
            //     }
            //   }),
            // ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedDatabase,
              label: 'Church Database',
              // items: ['User List'],
              items: ['User List', 'Members List', 'Families','Little Flocks','Student','Committee','Pastors','Church Staff','Department',],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                  if (pageIndexMap.containsKey(item)) {
                    print('select value $item');
                    widget.onItemSelected(pageIndexMap[item]!);
                  }
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedUserGroup,
              label: 'Membership',
              items: ['Membership Reports', 'Membership Register',],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                  if (pageIndexMap.containsKey(item)) {
                    widget.onItemSelected(pageIndexMap[item]!);
                  }
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedFileDollar,
              label: 'Finance',
              items: ['Fund Management', 'Donations','Asset Management'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                  if (pageIndexMap.containsKey(item)) {
                    widget.onItemSelected(pageIndexMap[item]!);
                  }
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedManager,
              label: 'Engagement',
              items: ['Wishes', 'Sms Communication','Email Communication','Notification','Blood Requirement','Blog','Social Media'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                  if (pageIndexMap.containsKey(item)) {
                    widget.onItemSelected(pageIndexMap[item]!);
                  }
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedWrench02,
              label: 'Church Tools',
              items: ['Speech', 'Testimony','Prayers','Meetings','Event Management','Remembrance Days','Notices','Function Hall','Audio Podcast'],
              // items: ['Speech', 'Testimony','Prayers','Meetings','Event Management','Remembrance Days','Notices','Function Hall','Audio Podcast','Certificate Generation'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                  if (pageIndexMap.containsKey(item)) {
                    widget.onItemSelected(pageIndexMap[item]!);
                  }
                });
              },
            ),
            // DropdownButtonWidget(
            //   icon: HugeIcons.strokeRoundedNotificationSquare,
            //   label: 'Attendance',
            //   items: ['Member Attendance', 'Student Attendance'],
            //   selectedItem: selectedItem,
            //   onItemSelected: (item) {
            //     setState(() {
            //       selectedItem = item;
            //       if (pageIndexMap.containsKey(item)) {
            //         widget.onItemSelected(pageIndexMap[item]!);
            //       }
            //     });
            //   },
            // ),
            DashboardButton(
              icon: HugeIcons.strokeRoundedAlbum02,
              label: 'Gallery',
              isSelected: selectedItem == 'Gallery',
              onPressed: (isSelected) => setState(() {
                selectedItem = 'Gallery';
                if (pageIndexMap.containsKey(selectedItem)) {
                  widget.onItemSelected(pageIndexMap[selectedItem]!);
                }
              }),
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedSecurity,
              label: 'Security',
              items: ['Manage Role', 'Login Reports'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                  if (pageIndexMap.containsKey(item)) {
                    widget.onItemSelected(pageIndexMap[item]!);
                  }
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedActivity03,
              label: 'Zone Activities',
              items: ['Zone Areas', 'Zone List','Zone Reports'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                  if (pageIndexMap.containsKey(item)) {
                    widget.onItemSelected(pageIndexMap[item]!);
                  }
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedBlockchain01,
              label: 'Ecommerce',
              items: ['Products', 'Orders'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                  if (pageIndexMap.containsKey(item)) {
                    widget.onItemSelected(pageIndexMap[item]!);
                  }
                });
              },
            ),
            DashboardButton(
              icon: HugeIcons.strokeRoundedShoppingBag01,
              label: 'Consumables',
              isSelected: selectedItem == 'Consumables',
              onPressed: (isSelected) => setState(() {
                selectedItem = 'Consumables';
                if (pageIndexMap.containsKey(selectedItem)) {
                  widget.onItemSelected(pageIndexMap[selectedItem]!);
                }
              }),
            ),
            DashboardButton(
              icon: HugeIcons.strokeRoundedNews01,
              label: 'News Letter',
              isSelected: selectedItem == 'News Letter',
              onPressed: (isSelected) => setState(() {
                selectedItem = 'News Letter';
                if (pageIndexMap.containsKey(selectedItem)) {
                  widget.onItemSelected(pageIndexMap[selectedItem]!);
                }
              }),
            ),
            DashboardButton(
              icon: HugeIcons.strokeRoundedWhatsapp,
              label: 'Whatsapp',
              isSelected: selectedItem == 'Whatsapp',
              onPressed: (isSelected) => setState(() {
                selectedItem = 'Whatsapp';
                if (pageIndexMap.containsKey(selectedItem)) {
                  widget.onItemSelected(pageIndexMap[selectedItem]!);
                }
              }),
            ),
          
          
          ],
        ),
      ),
    );

  }

}


/*class SidebarUi extends StatefulWidget {
  final Function(int) onItemSelected; // Callback function

  const SidebarUi({super.key, required this.onItemSelected});

  @override
  State<SidebarUi> createState() => _SidebarUiState();
}

class _SidebarUiState extends State<SidebarUi> {
  String selectedItem = 'Dashboard'; // Default selected item

  final Map<String, int> pageIndexMap = {
    'Dashboard': 0,
    'Membership Reports': 1,
    'Membership Register': 2,
    'Fund Management': 3,
    'Donations': 4,
    'Asset Management': 5,
    'Email Communication': 6,
    'Notification': 7,
    'Blood Requirement': 8,
    'Blog': 9,
    'Testimony': 10,
    'Prayers': 11,
    'Event Management': 12,
    'Remembrance Days': 13,
    'Notices': 14,
    'Function Hall': 15,
    'Audio Podcast': 16,
    'Member Attendance': 17,
    'Student Attendance': 18,
    'Gallery': 19,
    'Manage Role': 20,
    'Login Reports': 21,
    'Zone Areas': 22,
    'Zone List': 23,
    'Zone Reports': 24,
    'Products': 25,
    'Orders': 26,
    'Consumables': 27,
    'News Letter': 28,
    'Whatsapp': 29,
  };

  @override
  Widget build(BuildContext context) {
   return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.3, horizontal: 12.2),
        // margin: const EdgeInsets.symmetric(vertical: 14.3, horizontal: 12.2),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  'IKIA Church',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            // Drawer Items
            DashboardButton(
              icon: HugeIcons.strokeRoundedHome06,
              label: 'Dashboard',
              isSelected: selectedItem == 'Dashboard',
              onPressed: () => setState(() {
                selectedItem = 'Dashboard';
              }),
            ),

            DashboardButton(
              icon: HugeIcons.strokeRoundedAnalyticsUp,
              label: 'Reports',
              isSelected: selectedItem == 'Reports',
              onPressed: () => setState(() {
                selectedItem = 'Reports';
              }),
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedDatabase,
              label: 'Church Database',
              items: ['User List', 'Members List', 'Families','Little Flocks','Student','Committee','Pastors','Church Staff','Department',],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedUserGroup,
              label: 'Membership',
              items: ['Membership Reports', 'Membership Register',],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedFileDollar,
              label: 'Finance',
              items: ['Fund Management', 'Donations','Asset Management'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedManager,
              label: 'Engagement',
              items: ['Wishes', 'Sms Communication','Email Communication','Notification','Blood Requirement','Blog','Social Media'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedWrench02,
              label: 'Church Tools',
              items: ['Speech', 'Testimony','Prayers','Meetings','Event Management','Remembrance Days','Notices','Function Hall','Audio Podcast','Certificate Generation'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedNotificationSquare,
              label: 'Attendance',
              items: ['Member Attendance', 'Student Attendance'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            DashboardButton(
              icon: HugeIcons.strokeRoundedAlbum02,
              label: 'Gallery',
              isSelected: selectedItem == 'Gallery',
              onPressed: () => setState(() {
                selectedItem = 'Gallery';
              }),
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedSecurity,
              label: 'Security',
              items: ['Manage Role', 'Login Reports'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedActivity03,
              label: 'Zone Activities',
              items: ['Zone Areas', 'Zone List','Zone Reports'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            DropdownButtonWidget(
              icon: HugeIcons.strokeRoundedBlockchain01,
              label: 'Ecommerce',
              items: ['Products', 'Orders'],
              selectedItem: selectedItem,
              onItemSelected: (item) {
                setState(() {
                  selectedItem = item;
                });
              },
            ),
            DashboardButton(
              icon: HugeIcons.strokeRoundedShoppingBag01,
              label: 'Consumables',
              isSelected: selectedItem == 'Consumables',
              onPressed: () => setState(() {
                selectedItem = 'Consumables';
              }),
            ),
            DashboardButton(
              icon: HugeIcons.strokeRoundedNews01,
              label: 'News Letter',
              isSelected: selectedItem == 'News Letter',
              onPressed: () => setState(() {
                selectedItem = 'News Letter';
              }),
            ),
            DashboardButton(
              icon: HugeIcons.strokeRoundedWhatsapp,
              label: 'Whatsapp',
              isSelected: selectedItem == 'Whatsapp',
              onPressed: () => setState(() {
                selectedItem = 'Whatsapp';
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build sidebar buttons
  Widget _buildSidebarButton(String label) {
    return ListTile(
      title: Text(label),
      selected: selectedItem == label,

    );
  }

  Widget _buildDropdown({required IconData icon, required String label, required List<String> items}) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(label),
      children: items.map((item) {
        return ListTile(
          title: Text(item),
          selected: selectedItem == item,
          onTap: () {
            setState(() {
              selectedItem = item;
            });
            if (pageIndexMap.containsKey(item)) {
              widget.onItemSelected(pageIndexMap[item]!);
            }
          },
        );
      }).toList(),
    );
  }
}*/

