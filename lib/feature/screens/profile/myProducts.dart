import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_store/core/services/routing.dart';
import 'package:secure_store/core/widget/noschdule.dart';
import 'package:secure_store/core/widget/product_card.dart';
import 'package:secure_store/feature/home/home/product_details.dart';
import 'package:secure_store/feature/presentation/data/cubit/auth_cubit.dart';
import 'package:secure_store/feature/presentation/model/view/view_model/Product_model.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({super.key});

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? _documentID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future<void> deleteProduct(String docID) {
    return FirebaseFirestore.instance
        .collection('Product')
        .doc(user?.uid.toString())
        .collection('all')
        .doc(docID)
        .delete();
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

      child:
       StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .where('userId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text('Error occurred');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const NoScheduledWidget();
          } else {
            return Scrollbar(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot product = snapshot.data!.docs[index];

                  return ProductCard(
                    title: product['productTitle'],
                    price: product['productPrice'],
                    image: product['productImage'],
                    onPressed: () {
                      push(
                        context,
                        HomeDetails(
                          title: product['productTitle'],
                          price: product['productPrice'],
                          description: product['productDescription'],
                          image: product['productImage'],
                          phone: '',
                          userId: product['userId'],
                          userName: product['userName'],
                        ),
                      );
                    },
                    onRemovedPressed: () async {
                      await authCubit.removeProduct(
                          productId: product['productTitle']);
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
