import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/core/widget/product_card.dart';
import 'package:secure_store/feature/home/home/product_details.dart';
class SearchHomeView extends StatefulWidget {
  final String searchKey;
  const SearchHomeView({Key? key, required this.searchKey}) : super(key: key);

  @override
  _SearchHomeViewState createState() => _SearchHomeViewState();
}

class _SearchHomeViewState extends State<SearchHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('find your product',
          style: getTitleStyle(color: appcolors.whitecolor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Product')
              .orderBy('productTitle')
              .startAt([widget.searchKey]).endAt(
                  ['${widget.searchKey}\uf8ff']).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          Text('not founded',
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
                             
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeDetails(
                              title: Product['productTitle'],
                              price: Product['productPrice'],
                              description: Product['productDescription'],
                              image: Product['productImage'], phone: '',
                                   userId:  Product['userId'],
                           userName:  Product['userName'], 
                                  ),
                                ),
                              );
                            },
                            onRemovedPressed: (){},
                            );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}