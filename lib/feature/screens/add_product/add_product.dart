import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secure_store/core/services/routing.dart';
import 'package:secure_store/core/services/showLoadingDialog.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/feature/screens/bottomNavBar.dart';
import 'package:secure_store/feature/presentation/data/cubit/auth_cubit.dart';
import 'package:secure_store/feature/presentation/data/cubit/auth_state.dart';
import 'package:secure_store/feature/presentation/model/view/view_model/categoryList.dart';
import 'package:secure_store/feature/presentation/model/view/view_model/Product_model.dart';
import 'package:secure_store/feature/screens/profile/userProfile.dart';
import 'package:secure_store/feature/screens/profile/userProfile.dart';
import 'package:secure_store/feature/screens/profile/userProfile.dart';
import 'package:secure_store/feature/screens/profile/userProfile.dart';
import 'package:uuid/uuid.dart';

class addProductView extends StatefulWidget {
  const addProductView({Key? key}) : super(key: key);

  @override
  State<addProductView> createState() => _addProductViewState();
}

class _addProductViewState extends State<addProductView> {
  String? _imagePath;
  File? file;
  String? profileUrl;

  Uuid? uuid;

  void initState() {
    super.initState();

    _getProduct();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _Description = TextEditingController();
  final TextEditingController _Title = TextEditingController();
  final TextEditingController _Price = TextEditingController();
  final TextEditingController _Phone = TextEditingController();
   String _category = category[0];

  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://store-12a8f.appspot.com');

  // method to upload and get link of image
  Future<String> uploadImageToFireStore(File image) async {
    //2) choose file location (path)
    var ref = _storage.ref().child('${DateTime.now()}');
    //3) choose file type (image/jpeg)
    var metadata = SettableMetadata(contentType: 'image/jpeg');
    // 4) upload image to Firebase Storage
    await ref.putFile(image, metadata);
    // 5) get image url
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> _pickImage() async {
    _getProduct();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        // to upload the file (image) to firebase storage
        file = File(pickedFile.path);
      });
    }
    profileUrl = await uploadImageToFireStore(file!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is UpdateProductDataSuccesState) {
          push(context, const NavBar());
        } else if (state is UpdateProductDataErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, Text('error'));
        } else {
          CircularProgressIndicator();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          // actions: [
          //   IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new))
          // ],
          backgroundColor: appcolors.primerycolor,
          centerTitle: true,
          title: Text(
            'Add product',
            style: getbodyStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(2),
                    SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: GestureDetector(
                          onTap: () async {
                            await _pickImage();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                            image: (_imagePath != null)
                                ? FileImage(File(_imagePath!)) as ImageProvider
                                : const AssetImage('assets/camera.png'),
                            fit: BoxFit.cover,
                          ))),
                        )),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _Title,
                      maxLines: 1,
                      style: TextStyle(color: appcolors.whitecolor),
                      decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          hintText: 'name',
                          hintStyle: TextStyle(color: Colors.white)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter item name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(10),

                    TextFormField(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      controller: _Price,
                      style: TextStyle(color: appcolors.whitecolor),
                      decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          hintText: 'price',
                          hintStyle: TextStyle(color: Colors.white)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter item price';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Divider(
                      color: appcolors.blackcolor,
                      endIndent: 15,
                      indent: 15,
                    ), Gap(10),

                    TextFormField(
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      controller: _Phone,
                      style: TextStyle(color: appcolors.whitecolor),
                      decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          hintText: 'Phone',
                          hintStyle: TextStyle(color: Colors.white)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter your phone';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Divider(
                      color: appcolors.blackcolor,
                      endIndent: 15,
                      indent: 15,
                    ),
                    Gap(5),
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: getbodyStyle(fontSize: 16),
                        )
                      ],
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      controller: _Description,
                      style: TextStyle(color: appcolors.whitecolor),
                      decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          hintText: 'enter item description',
                          hintStyle: TextStyle(color: Colors.white)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'enter item description';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton(
                        isExpanded: true,
                        iconEnabledColor: appcolors.whitecolor,
                        icon: const Icon(Icons.expand_circle_down_outlined),
                        value: _category,
                        onChanged: (String? newValue) {
                          setState(() {
                            _category = newValue ?? category[0];
                          });
                        },
                        items: category.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: appcolors.greycolor,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    // ... rest of your code
                    TextButton(
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;
                          final authCubit =context.read<AuthCubit>();
                          if (_formKey.currentState!.validate()) {
                            authCubit. updateProductData (
                                ProductModel(
                                    productId: _Title.text,
                                    productTitle: _Title.text,
                                    productPrice: _Price.text,
                                    productCategory: _category,
                                    productDescription: _Description.text,
                                    productImage: profileUrl ?? '',
                                    productPhone: _Phone.text,
                          
                                    userId: user!.uid,
                                    userName: user.displayName??'None', 
                                    )) ;
                          }
                        },
                        child: Text('Done', style: getbodyStyle()))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showErrorDialog(BuildContext context, Text text) {}
}

class _getProduct {}
