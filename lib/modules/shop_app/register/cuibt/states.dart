
import 'package:flutter_application_1/models/shop/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterintinalstate extends ShopRegisterStates {}

class ShopRegisterloadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  late final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  ShopRegisterErrorState(this.error);

  final String error;
}

class ShopRegisterChangePasswordState extends ShopRegisterStates {}
