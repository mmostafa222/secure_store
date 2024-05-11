import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:secure_store/core/services/routing.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/core/widget/custombtn.dart';
import 'package:secure_store/feature/home/home/product_details.dart';

import 'package:secure_store/feature/presentation/data/cubit/auth_cubit.dart';
import 'package:secure_store/feature/presentation/data/cubit/auth_state.dart';
import 'package:secure_store/feature/presentation/model/view/view_model/Product_model.dart';
import 'package:secure_store/feature/screens/chat/ui/chat_message_screen/chat_message_screen.dart';


class productList extends StatefulWidget {
  final category;
  const productList({super.key, required this.category});

  @override
  _productListState createState() => _productListState();
}

class _productListState extends State<productList> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isVisable = true;

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
    // orderBy  للترتيب
    // where  للمقارنة
    // startAt and endAt  للسيرش
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Product')
            .where('productCategory', isEqualTo: widget.category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot product = snapshot.data!.docs[index];
                print(product['productTitle']);
                if (product['productTitle'] == null ||
                    product['productImage'] == null ||
                    product['productPrice'] == null ||
                    product['productPhone'] == null ||
                    product['productDescription'] == null) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Stack(children: [
                    Container( width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: appcolors.greycolor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Image.network(product['productImage'],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(product['productTitle'],
                                          style: getTitleStyle(
                                              fontSize: 12,
                                              color: appcolors.primerycolor)),
                                      Text(product['productPrice'],
                                          style: getbodyStyle(fontSize: 11)),
                                      Text(product['productPhone'],
                                          maxLines: 1,
                                          style: getsmallStyle(fontSize: 15,
                                              color: Colors.green))
                                    ],
                                  ),
                                ),
                                CustomButton(
                                  text: 'view',
                                  onPressed: () {
                                    push(
                                        context,
                                        HomeDetails(
                                          title: product['productTitle'],
                                          phone: product['productPhone'],
                                          price: product['productPrice'],
                                          description:
                                              product['productDescription'],
                                          image: product['productImage'],
                                          userId: product['userId'],
                                          userName: product['userName'],
                                        ));
                                  },
                                  Function: () {},
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BlocListener<AuthCubit, AuthStates>(
                                      listener: (BuildContext context,
                                          AuthStates state) {
                                        if (state
                                            is UpdateCartDataSuccesState) {
                                          // push(context, const favoriteView());
                                        } else
                                          showErrorDialog(
                                              context, const Text('error'));
                                      },
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isVisable = !isVisable;
                                            });

                                            context
                                                .read<AuthCubit>()
                                                .updateCartData(
                                                  ProductModel(
                                                    productId: '',
                                                    productTitle:
                                                        product['productTitle'],
                                                    productPrice:
                                                        product['productPrice'],
                                                    productCategory: '',
                                                    productDescription: product[
                                                        'productDescription'],
                                                    productImage:
                                                        product['productImage'],
                                                    productPhone: '',
                                                    userId: product['userId'],
                                                    userName:
                                                        product['userName'],
                                                  ),
                                                );
                                          },
                                          icon: Icon((isVisable)
                                              ? Icons.favorite_border
                                              : Icons.favorite)),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ChatMessageScreen(
                                            reciverID: product['userId'],
                                            reciverName: product['userName'],
                                          );
                                        }));
                                      },
                                      icon: Icon(
                                        Icons.message_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )),
                  ]),
                );
              },
            );
          }
        },
      ),
    );
  }

  void showErrorDialog(BuildContext context, Text text) {}
}

//  void showErrorDialog(BuildContext context, Text text) {}

// Future<void> createCart() async {
//   var cart;
//   var user;
//   FirebaseFirestore.instance.collection('Cart').doc('cart.productTitle').set({
//     'cartID': cart.productTitle,
//     'id': user!.uid,
//   }, SetOptions(merge: true));

//   FirebaseFirestore.instance
//       .collection('Cart')
//       .doc('Cart')
//       .collection('all')
//       .doc()
//       .set({
//     'cartID': cart.productTitle,
//   }, SetOptions(merge: true));
// }
//  IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 isVisable = !isVisable;
//                               });
//                             },
//                             icon: Icon((isVisable)
//                                 ? Icons.remove_red_eye
//                                 : Icons.visibility_off_rounded)),