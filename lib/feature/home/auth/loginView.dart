import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:secure_store/core/services/routing.dart';
import 'package:secure_store/core/services/showLoadingDialog.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/feature/screens/bottomNavBar.dart';
import 'package:secure_store/feature/home/auth/register.dart';
import 'package:secure_store/feature/presentation/data/cubit/auth_cubit.dart';
import 'package:secure_store/feature/presentation/data/cubit/auth_state.dart';

class loginView extends StatefulWidget {
  const loginView({
    super.key,
  });

  @override
  State<loginView> createState() => _loginViewState();
}

class _loginViewState extends State<loginView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccesState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => NavBar()),
              (route) => false);
        } else if (state is LoginErrorState) {
          Navigator.pop(context);
        } else {
          showLoadingDialogo(context);
        }
      },
      child: Scaffold(
        backgroundColor: appcolors.whitecolor,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Lottie.asset(
                        'assets/secure.json',
                        height: 200,
                        width: 490,
                      ),
                    ),
                    Gap(9),
                    Text(
                      '  Secure Store',
                      style: getbodyStyle(
                          color: appcolors.primerycolor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Gap(20),
                    TextFormField(  style: TextStyle(color: appcolors.whitecolor),
                    
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailcontroller,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        filled: true,
                        focusColor: appcolors.primerycolor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'email@.com',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.email),
                      ),
                       validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email';
                        } else if (!emailValidate(value)) {
                          return 'please enter correct email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(30),
                    TextFormField(  style: TextStyle(color: appcolors.whitecolor),
                    
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordcontroller,
                      obscureText: isVisable,
                      validator: (value) {
                        if (value!.isEmpty) return 'please enter your password';
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        focusColor: appcolors.primerycolor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: '********',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: Icon((isVisable)
                                ? Icons.remove_red_eye
                                : Icons.visibility_off_rounded)),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              textAlign: TextAlign.end,
                              ' forget password',
                              style: getTitleStyle(
                                  color: appcolors.primerycolor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        )),
                    Gap(11),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: SizedBox(
                        width: 380,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor: appcolors.primerycolor,
                                foregroundColor: appcolors.whitecolor,
                                elevation: 0),
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                context.read<AuthCubit>().Login(
                                      _emailcontroller.text,
                                      _passwordcontroller.text,
                                    );
                              }
                              ;
                            },
                            child: Text(
                              ' login',
                              style: getbodyStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.amber),
                            )),
                      ),
                    )
                    // SizedBox(width: 350,
                    // height: 50,
                    //   child: custombtn(
                    //       text: ('تسجيل الدخول'),
                    //       backgroundColor: appcolors.blue,
                    //       foregroundColor: appcolors.white,
                    //       onPressed: () {}),
                    // ),
                    ,
                    Row(
                      children: [
                        Text(
                          '          don`t have account?',
                          style: getsmallStyle(
                              color: appcolors.primerycolor,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                        Gap(2),
                        TextButton(
                            onPressed: () {
                              pushwithReplacement(context, RegisterView());
                            },
                            child: Text(
                              'sign up',
                              style: getbodyStyle(
                                  color: Colors.amber, fontSize: 15),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool emailValidate(String email) {
  // Regular expression for a simple email validation
  // This is a basic example and may not cover all valid email formats
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  return emailRegex.hasMatch(email);
}
