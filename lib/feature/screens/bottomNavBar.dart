import 'package:secure_store/core/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:secure_store/feature/home/home/home.dart';
import 'package:secure_store/feature/screens/chat/ui/chat_list_screen/chat_list.dart';

import 'package:secure_store/feature/screens/add_product/add_product.dart';
import 'package:secure_store/feature/screens/favorite/favorite.dart';
import 'package:secure_store/feature/screens/profile/userProfile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _index = 0;
  List<Widget> screens = [
    const homePage(),
    const ChatList(),addProductView(),
    favoriteView(),
    const ClientProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: appcolors.primerycolor,
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.chat_rounded,
            ),
            title: Text("chat"),
            selectedColor: appcolors.primerycolor,
          ),

          /// Likes

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.add),
            title: Text("Add"),
            selectedColor: appcolors.greycolor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text("favorite"),
            selectedColor: appcolors.blackcolor,
          ),

          //Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: appcolors.blackcolor,
          ),
        ],
      ),
    );
  }
}
