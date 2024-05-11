import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/core/widget/settingslistItem.dart';
import 'package:secure_store/feature/home/auth/loginView.dart';
import 'package:secure_store/feature/screens/profile/myProducts.dart';
import 'package:secure_store/feature/screens/profile/userDetailes.dart';
class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: appcolors.primerycolor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: appcolors.whitecolor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          'settings',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SettingsListItem(
              icon: Icons.person,
              text: 'account settings',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contex) => const UserDetails()));
              },
            ),
            SettingsListItem(
              icon: Icons.production_quantity_limits,
              text: 'my products',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (contex) => const MyProducts()));},
            ),
            // SettingsListItem(
            //   icon: Icons.notifications_active_rounded,
            //   text: 'notifications',
            //   onTap: () {},
            // ),
            // SettingsListItem(
            //   icon: Icons.privacy_tip_rounded,
            //   text: 'privacy',
            //   onTap: () {},
            // ),
            // SettingsListItem(
            //   icon: Icons.question_mark_rounded,
            //   text: 'support & help',
            //   onTap: () {},
            // ),
            // SettingsListItem(
            //   icon: Icons.person_add_alt_1_rounded,
            //   text: 'invite',
            //   onTap: () {},
            // ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const loginView(),
                      ),
                      (Route<dynamic> route) => false);
                  _signOut();
                },
                child: Text(
                  'Log out',                  style: getTitleStyle(color: appcolors.whitecolor, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}