import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_store/core/services/routing.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/core/widget/product_card.dart';
import 'package:secure_store/feature/home/home/product_details.dart';

class searchList extends StatefulWidget {
  final String searchKey;
  // ignore: prefer_typing_uninitialized_variables
  final  product;
  const searchList({Key? key, required this.searchKey, this.product}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<searchList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Product')
          .orderBy('productTitle')
          .startAt([widget.searchKey]).endAt(
              ['${widget.searchKey}\uf8ff']).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return snapshot.data?.size == 0
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'not founded',
                        style: getbodyStyle(),
                      ),
                    ],
                  ),
                ),
              )
            : Scrollbar(
                child: ListView.builder(
                  itemCount: snapshot.data?.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot Product = snapshot.data!.docs[index];
                   
                    return ProductCard(
                              title: Product['productTitle'],
                              price: Product['productPrice'],
                              image: Product['productImage'],
                      onPressed: () {
                        
                        push(
                            context,
                            HomeDetails(
                              title: Product['productTitle'],
                              price: Product['productPrice'],
                              description: Product['productDescription'],
                              image: Product['productImage'], phone: Product['productPhone'],
                           userId:  Product['userId'],
                           userName:  Product['userName'],
                            ));
                      },
                      onRemovedPressed: (){},
                    );
                  },
                ),
              );
      },
    );
  }
}
