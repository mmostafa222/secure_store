class AuthStates{}

class AuthInitStates extends AuthStates{

}
class LoginLoadingState extends AuthStates{}
class LoginSuccesState extends AuthStates{}
class LoginErrorState extends AuthStates{
  final String error;

  LoginErrorState({required this.error});
}


class SignUpLoadingState extends AuthStates{}
class SignUpSuccesState extends AuthStates{}
class SignUpErrorState extends AuthStates{
  final String error;

  SignUpErrorState({required this.error});
}

class UploadClientDataLoadingState extends AuthStates{}
class UploadClientDataSuccesState extends AuthStates{}
class UploadClientDataErrorState extends AuthStates{
  final String error;

  UploadClientDataErrorState({required this.error});
}
class UpdateProductDataLoadingState extends AuthStates{}
class UpdateProductDataSuccesState extends AuthStates{}
class UpdateProductDataErrorState extends AuthStates{
  final String error;

  UpdateProductDataErrorState({required this.error});
}
class UpdateCartDataLoadingState extends AuthStates{}
class UpdateCartDataSuccesState extends AuthStates{}
class UpdateCartDataErrorState extends AuthStates{
  final String error;

  UpdateCartDataErrorState({required this.error});
}

// Remove from fav
class RemoveCartDataLoadingState extends AuthStates{}
class RemoveCartDataSuccesState extends AuthStates{}
class RemoveeCartDataErrorState extends AuthStates{
  final String error;

  RemoveeCartDataErrorState({required this.error});
}

//Remove product
class RemoveProductDataLoadingState extends AuthStates{}
class RemoveProductDataSuccesState extends AuthStates{}
class RemoveeProductDataErrorState extends AuthStates{
  final String error;

  RemoveeProductDataErrorState({required this.error});
}
