import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_store/feature/screens/favorite/MyFavoriteList.dart';

class favoriteView extends StatefulWidget {
  const favoriteView({super.key});

  @override
  _favoriteViewState createState() => _favoriteViewState();
}

class _favoriteViewState extends State<favoriteView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromARGB(255, 172, 19, 8),
        title: const Text('MY Favorite List',
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: MyFavoriteList(),
      ),
    );
  }
}