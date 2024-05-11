import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_store/core/services/routing.dart';
import 'package:secure_store/core/widget/noschdule.dart';
import 'package:secure_store/core/widget/product_card.dart';
import 'package:secure_store/feature/home/home/product_details.dart';

import '../../presentation/data/cubit/auth_cubit.dart';

class MyFavoriteList extends StatefulWidget {
  const MyFavoriteList({super.key, this.product});
  final product;
  @override
  _MyFavoriteListState createState() => _MyFavoriteListState();
}

class _MyFavoriteListState extends State<MyFavoriteList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? _documentID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future<void> deleteFavProduct(
    String productID,
  ) {
    return FirebaseFirestore.instance
        .collection('Cart')
        .doc('productPrice')
        .delete();
  }

  showAlertDialog(BuildContext context, String productID) {
    Widget cancelButton = TextButton(
      child: const Text("no"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("yes"),
      onPressed: () {
        deleteFavProduct(
          _documentID!,
        );
        Navigator.of(context).pop();
      },
    );

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text("delete product "),
      content: const Text(" confirm to delete product ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Cart')
              .orderBy('productPrice')

              //.orderBy('date', descending: false)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data?.size == 0
                ? const NoScheduledWidget()
                : Scrollbar(
                    child: ListView.builder(
                      itemCount: snapshot.data?.size,
                      itemBuilder: (context, index) {
                        DocumentSnapshot Cart = snapshot.data!.docs[index];

                        return ProductCard(
                          title: Cart['productTitle'],
                          price: Cart['productPrice'],
                          image: Cart['productImage'],
                          onPressed: () {
                            push(
                                context,
                                HomeDetails(
                                  title: Cart['productTitle'],
                                  price: Cart['productPrice'],
                                  description: Cart['productDescription'],
                                  image: Cart['productImage'],
                                  phone: '',
                                  userId: Cart['userId'],
                                  userName: Cart['userName'],
                                ));
                          },
                          onRemovedPressed: () async {
                            await authCubit.removeProductFromCart(
                                productId: Cart['productPrice']);
                          },
                        );
                      },
                    ),
                  );
          }),
    );
  }
}
