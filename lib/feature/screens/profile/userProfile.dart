import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/core/widget/tileWidget.dart';
import 'package:secure_store/feature/screens/profile/myProducts.dart';
import 'package:secure_store/feature/screens/profile/userSettings.dart';
class ClientProfile extends StatefulWidget {
  const ClientProfile({Key? key}) : super(key: key);

  @override
  _ClientProfileState createState() => _ClientProfileState();
}
var imagePath;


File? file;

String? profilurl;


  User? user;
  String? UserID;

  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
    UserID = user?.uid;
  }

class _ClientProfileState extends State<ClientProfile> {
  // 1) instance from FirebaseStorage with bucket Url..
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://store-12a8f.appspot.com');

  // method to upload and get link of image
  Future<String> uploadImageToFireStore(File image) async {
    //2) choose file location (path)
    var ref =
        _storage.ref().child('Client/${FirebaseAuth.instance.currentUser!.uid}');
    //3) choose file type (image/jpeg)
    var metadata = SettableMetadata(contentType: 'image/jpeg');
    // 4) upload image to Firebase Storage
    await ref.putFile(image, metadata);
    // 5) get image url
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> pickImage() async {
      _getUser();
    final PickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
        file = File(PickedFile.path);
      });
    } profilurl = await uploadImageToFireStore(file!, );
    FirebaseFirestore.instance.collection('Client').doc(UserID).set({
      'image': profilurl,
    }, SetOptions(merge: true));
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
        elevation: 0,
        title: const Text(
          'Account',
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.settings,
              color: appcolors.whitecolor,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (contex) => const UserSettings()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Client')
                .doc(user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var userData = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 62,
                                  backgroundColor: appcolors.primerycolor,
                                  child: CircleAvatar(
                                      backgroundColor: appcolors.whitecolor,
                                      radius: 60,
                                      backgroundImage: (imagePath != null)
                                          ? FileImage(File(imagePath!))
                                              as ImageProvider
                                          : const AssetImage(
                                              'assets/person.png',
                                            )),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await pickImage();
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: const Icon(
                                      Icons.camera_alt_rounded,
                                      size: 20,
                                      // color: AppColors.color1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${userData!['name']}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: getTitleStyle(fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                       
                       
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(color: Colors.black),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "contact",
                          style: getbodyStyle(fontWeight: FontWeight.w600,fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appcolors.whitecolor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TileWidget(
                                  text: userData['email'] ?? 'not added',
                                  icon: Icons.email),
                              const SizedBox(
                                height: 25,
                              ),
                              TileWidget(
                                  text: userData['phone'] ?? 'not added',
                                  icon: Icons.call),
                                   const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),  const Divider(),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          "My products",
                          style: getbodyStyle(fontWeight: FontWeight.w600 ,fontSize: 15) ,
                        ),
                        const MyProducts ()
                      ],
                    )),
              );
            }),
      ),
    );
  }
}
