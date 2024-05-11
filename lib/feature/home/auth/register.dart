import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:secure_store/core/services/showLoadingDialog.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/feature/screens/bottomNavBar.dart';
import 'package:secure_store/feature/home/auth/loginView.dart';
import 'package:secure_store/feature/presentation/data/cubit/auth_cubit.dart';
import 'package:secure_store/feature/presentation/data/cubit/auth_state.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key,});
 

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisable = true;


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignUpSuccesState) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> NavBar()), (route) => false);
        } else if (state is SignUpErrorState) {
          Navigator.pop(context);
          
        } else {
          showLoadingDialogo(context);
        }
      },
      child: Scaffold(backgroundColor:appcolors.whitecolor,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                   Lottie.asset('assets/secure.json',height: 200),
                    const SizedBox(height: 20),
                    Text(
                      'secure store ',
                      style: getTitleStyle(color: appcolors.primerycolor),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _displayName,
                      style: TextStyle(color: appcolors.whitecolor),
                      decoration: InputDecoration(
                        hintText: 'name',
                        hintStyle: getsmallStyle(color: Colors.grey),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) return 'please enter your name';
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(  style: TextStyle(color: appcolors.whitecolor),
                    
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        hintText: 'email@example.com',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.email_rounded),
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
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      textAlign: TextAlign.start,
                      style: TextStyle(color: appcolors.whitecolor),
                      obscureText: isVisable,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: '********',
                         hintStyle: TextStyle(color: Colors.grey),
                       
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: Icon((isVisable)
                                ? Icons.remove_red_eye
                                : Icons.visibility_off_rounded)),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) return 'please enter your password';
                        return null;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton( style: ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        backgroundColor:appcolors.primerycolor,
                        foregroundColor: appcolors.whitecolor ,
                        elevation: 0),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              
                                context.read<AuthCubit>().registerClient(
                                    _displayName.text,
                                    _emailController.text,
                                    _passwordController.text);
                              
                            }
                          
                         ElevatedButton.styleFrom(
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        backgroundColor:appcolors.primerycolor,
                        foregroundColor: appcolors.whitecolor ,
                        elevation: 0);
    }, 
                          child: Text(
                            "login",
                            style: getTitleStyle(color: Colors.amber),
                          )  ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'have account ?',
                            style: getsmallStyle(color: appcolors.primerycolor),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      loginView(),
                                ));
                              },
                              child: Text(
                                'login',
                                style: getbodyStyle(color: Colors.amber),
                              ))
                        ],
                      ),
                    ),
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
