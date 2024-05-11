import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/feature/screens/chat/ui/chat_message_screen/chat_message_screen.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails(
      {super.key,
      required this.title,
      required this.image,
      required this.price,
      required this.description,
      required this.phone,
      required this.userName,
      required this.userId});
  final String title;
  final String image;
  final String price;
  final String description;
  final String phone;
  final String userName;
  final String userId;
  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int isSelected = -1;
  User? user;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  get product => null;

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
      appBar: AppBar(
          backgroundColor: appcolors.primerycolor,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.favorite_border))
          ]),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Image.network(
            widget.image,
            height: 190,
            width: double.infinity,
          ),
        ),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: getTitleStyle(fontWeight: FontWeight.w900),
              ),
              const Divider(),

              const Gap(5),
              Text(
                widget.price,
                style: getTitleStyle(),
                // ), Divider(
                //         color: appcolors.primerycolor,
                //         endIndent: 15,
                //         indent: 15,
              ),
              // Text('Description', style: getsmallStyle(color: Colors.grey)),
              const Gap(5),
              const Divider(),
              Text(
                widget.description,
                style: getsmallStyle(fontSize: 13),
                textAlign: TextAlign.start,
              ),
              //  Text('Phone', style: getbodyStyle(color: Colors.grey)),
              const Gap(5),
              const Divider(),
              Text(
                widget.phone,
                style: getsmallStyle(fontSize: 14, color: Colors.green),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: appcolors.primerycolor,
          width: double.infinity,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Posted By',
                      style: TextStyle(color: Colors.white)),
                  Row(
                    children: [
                      Text(
                        widget.userName,
                        style: getTitleStyle(color: Colors.white),
                      ),
                      Gap(100),
                      // IconButton(
                      //   onPressed: () {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return ChatMessageScreen(
                      //         reciverID: product['userId'],
                      //         reciverName: product['userName'],
                      //       );
                      //     }));
                      //   },
                      //   icon: Icon(Icons.chat),
                      //   color: Color.fromARGB(255, 248, 248, 246),
                      //   iconSize: 40,
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(24),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //     height: 50,
            //     width: 200,
            //     child: CustomButton(
            //       onPressed: () {},
            //       text: 'Chat Now',
            //       fontSize: 33, Function: () {  },
            //     )),
          ],
        )
      ]),
    );
  }
}
