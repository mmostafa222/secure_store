import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_store/feature/presentation/data/cubit/auth_state.dart';
import 'package:secure_store/feature/presentation/model/view/view_model/Product_model.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitStates());

  registerClient(String name, String email, String password) async {
    try {
      emit(SignUpLoadingState());
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      await user.updateDisplayName(name);
      FirebaseFirestore.instance.collection('Client').doc(user.uid).set({
        'id': user.uid,
        'name': name,
        'email': user.email,
        'image': '',
        'phone': '',
        'rate': '',
      }, SetOptions(merge: true));

      emit(SignUpSuccesState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpErrorState(error: ' weak-password '));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpErrorState(error: '  the account already existes'));
      } else {
        emit(SignUpErrorState(error: 'wrong '));
      }
    }
  }

  Login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccesState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(error: 'الحساب غير موجود'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(error: 'كلمه السر خاطئه'));
      }
    }
  }

  registerAdmin(String name, String email, String password) async {
    try {
      emit(SignUpLoadingState());
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      await user.updateDisplayName(name);
      FirebaseFirestore.instance.collection('Admin').doc(user.uid).set({
        'id': user.uid,
        'name': name,
        'email': user.email,
      }, SetOptions(merge: true));

      emit(SignUpSuccesState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpErrorState(error: ' weak-password '));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpErrorState(error: '  the account already existes'));
      } else {
        emit(SignUpErrorState(error: 'wrong '));
      }
    }
  }

  uploadClientData({
    required String uid,
    required String image,
    required String phone,
    required String rate,
    required String name,
    required String email,
  }) async {
    emit(UploadClientDataLoadingState());

    try {
      FirebaseFirestore.instance.collection('Client').doc(uid).set({
        'image': image,
        'rate': rate,
        'phone': phone,
      }, SetOptions(merge: true));

      emit(UploadClientDataSuccesState());
    } catch (e) {
      emit(UploadClientDataErrorState(error: 'حدثت مشكله حاول لاحقا'));
    }
  }

  updateProductData(ProductModel product) {
    emit(UpdateProductDataLoadingState());

    try {
      FirebaseFirestore.instance
          .collection('Product')
          .doc(product.productTitle)
          .set({
        'productID': product.productTitle,
        'productTitle': product.productTitle,
        'productPrice': product.productPrice,
        'productPhone': product.productPhone,
        'productCategory': product.productCategory,
        'productDescription': product.productDescription,
        'productImage': product.productImage,
        'userId':product.userId,
        'userName':product.userName,
      }, SetOptions(merge: true));

      emit(UpdateProductDataSuccesState());
    } catch (e) {
      emit(UpdateProductDataErrorState(error: 'error'));
    }
  }

  Future<void> updateCartData(ProductModel product) async {
    print(product.productTitle);
    emit(UpdateCartDataLoadingState());

    try {
      await FirebaseFirestore.instance
          .collection('Cart')
          .doc(product.productPrice)
          .set({
        'cartID': product.productPrice,
        'productTitle': product.productTitle,
        'productPrice': product.productPrice,
        'productCategory': product.productCategory,
        'productDescription': product.productDescription,
        'productImage': product.productImage
      }, SetOptions(merge: true)).then((value) {
        print('Cart updated');
      });

      emit(UpdateCartDataSuccesState());
    } catch (e) {
      print(e.toString);
      emit(UpdateCartDataErrorState(error: 'error'));
    }
  }

  // Remove from cart

Future<void> removeProductFromCart({required String productId}) async {
  // Emit loading state to notify UI that removal is in progress
  emit(RemoveCartDataLoadingState());

  try {
    // Delete the document from the 'Cart' collection based on the product ID
    await FirebaseFirestore.instance
        .collection('Cart')
        .doc(productId)
        .delete()
        .then((_) {
      // Emit success state to notify UI that removal is successful
      emit(RemoveCartDataSuccesState());
      print('Product removed from cart successfully');
    });
  } catch (e) {
    // Emit error state to notify UI that an error occurred during removal
    emit(RemoveeCartDataErrorState(error: e.toString()));
    print('Error removing product from cart: $e');
  }
}

Future<void> removeProduct({required String productId}) async {
  // Emit loading state to notify UI that removal is in progress
  emit(RemoveProductDataLoadingState());

  try {
    // Delete the document from the  collection based on the product ID
    await FirebaseFirestore.instance
        .collection('Product')
        .doc(productId)
        .delete()
        .then((_) {
      // Emit success state to notify UI that removal is successful
      emit(RemoveProductDataSuccesState());
      print('Product removed  successfully');
    });
  } catch (e) {
    // Emit error state to notify UI that an error occurred during removal
    emit(RemoveeProductDataErrorState(error: e.toString()));
    print('Error removing product from : $e');
  }
}

}
