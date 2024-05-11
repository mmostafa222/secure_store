// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Firebase.initializeApp(
//     );
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('login'),
//       ),
//       body: Center(
//         child: MaterialButton(
//           onPressed: () async {
//             final _googleSignIn = GoogleSignIn();
//             final googleAccount = await _googleSignIn.signIn();
//             print(googleAccount!.email);
//             final googleCredential = await googleAccount.authentication;
//             final authCredential = GoogleAuthProvider.credential(
//                 idToken: googleCredential.idToken,
//                 accessToken: googleCredential.accessToken);

//             final firebaseUser = await FirebaseAuth.instance
//                 .signInWithCredential(authCredential);

//             print(firebaseUser.user!.uid);
//             print(firebaseUser.user!.displayName);
//             print(firebaseUser.user!.email);
//             print(firebaseUser.user!.emailVerified);
//             print(firebaseUser.user!.photoURL);
//             print(firebaseUser.user!.phoneNumber);
//             print(firebaseUser.user!.isAnonymous);

//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ChatList(),
//                 ));
//           },
//           color: Colors.red,
//           child: Text(
//             'login',
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }
