import 'package:flutter/material.dart';
import 'package:secure_store/core/utils/AppColors.dart';

class ChatsCard extends StatelessWidget {
  const ChatsCard({ required this.press, super.key, this.reciverName, required chat});
  
  final VoidCallback press;
  final reciverName;
  @override
  Widget build(BuildContext context) {
   
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/person.png'),
                ),
               
              ],
            ),
           
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'reciverName',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: appcolors.primerycolor),
                ),
               
              ],
            ),
           
          ],
        ),
      ),
    );
  }
 }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:secure_store/core/services/routing.dart';
// import 'package:secure_store/core/utils/AppColors.dart';
// import 'package:secure_store/core/utils/textstyle.dart';
// import 'package:secure_store/core/widget/custombtn.dart';
// import 'package:secure_store/feature/chat/ui/chat_message_screen/chat_message_screen.dart';
// import 'package:secure_store/feature/home/product_details.dart';
// import 'package:secure_store/feature/presentation/data/cubit/auth_cubit.dart';
// import 'package:secure_store/feature/presentation/data/cubit/auth_state.dart';
// import 'package:secure_store/feature/presentation/model/view/view_model/Product_model.dart';


// class chatsList extends StatefulWidget {
  
//   const chatsList({super.key, required Null Function() onPressed, });

//   @override
//   _chatsListstate createState() => _chatsListstate();
// }

// class _chatsListstate extends State<chatsList> {
//   @override
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   User? user;
//   bool isVisable = true;

//   Future<void> _getUser() async {
//     user = _auth.currentUser;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // orderBy  للترتيب
//     // where  للمقارنة
//     // startAt and endAt  للسيرش
//     return SafeArea(
//       child: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('messages')
//             .orderBy(TimeOfDay.now())
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return ListView.builder(
//               scrollDirection: Axis.vertical,
//               physics: const ClampingScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 DocumentSnapshot messages = snapshot.data!.docs[index];
//                 print(messages['userName']);
//                 if (messages[
//         'userName']   == null) {
//                   return const SizedBox();
//                 }
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   child: Stack(children: [
//                     Container(
//                         decoration: BoxDecoration(
//                             color: appcolors.greycolor,
//                             borderRadius: BorderRadius.circular(20)),
//                         child: Column(
//                           children: [
                            
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(25),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(messages['userName'],
//                                           style: getTitleStyle(
//                                               fontSize: 12,
//                                               color: appcolors.primerycolor)),
//                                      // Row(
//                                       //   children: [
//                                       //     // Text(product['productDescription'],
//                                       //     //     maxLines: 2,
//                                       //     //     style: getsmallStyle(
//                                       //     //         color: Colors.white)),
//                                       //   ],
//                                       // ),
                                     
//                                     ],
//                                   ),
//                                 ),
                               
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
                                   
//                                     IconButton(
//                                       onPressed: () {
//                                         Navigator.push(context,
//                                             MaterialPageRoute(
//                                                 builder: (context) {
//                                           var product;
//                                           return ChatMessageScreen(
//                                             reciverID: product['userId'],
//                                             reciverName: product['userName'],
//                                           );
//                                         }));
//                                       },
//                                       icon: Icon(
//                                         Icons.message_outlined,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             )
//                           ],
//                         )),
//                   ]),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   void showErrorDialog(BuildContext context, Text text) {}
// }
