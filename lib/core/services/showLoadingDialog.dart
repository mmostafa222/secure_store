import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showLoadingDialogo(BuildContext context){
  showDialog(
  
    context:context,
    builder:(BuildContext context){return
      Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
        children: [Lottie.asset('assets/loading.json',width: 300,height: 400)],
      );
    }
  );


  }
