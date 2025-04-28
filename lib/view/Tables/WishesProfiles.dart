import 'package:church_admin/view/Header/DashBoardHeader.dart';
import 'package:church_admin/view/Tables/TableForms/PastorsPopForm.dart';
import 'package:flutter/material.dart';
import '../../CustomColors.dart';
import '../../Widgets/AddProductListWidget.dart';
import '../../Widgets/OptionButton.dart';
import '../../Widgets/PastorProfileCard.dart';

class WishesProfile extends StatefulWidget {
  const WishesProfile({super.key});

  @override
  State<WishesProfile> createState() => _WishesProfileState();
}

class _WishesProfileState extends State<WishesProfile> {
  bool isChange = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F7FB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(),
            Padding(
              padding: const EdgeInsets.only(right: 100, left: 150, top: 20),
              child: AddProductTittleBar(titleName: 'Pastors'),
            ),
            Padding(
              padding: /*const EdgeInsets.all(120),*/ const EdgeInsets.only(
                  top: 30, right: 100, left: 100, bottom: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: users.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 68,
                  mainAxisSpacing: 40,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: PastorProfileCard(user: users[index]),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: OptionButton(
                          menuItems: actionButtons,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
