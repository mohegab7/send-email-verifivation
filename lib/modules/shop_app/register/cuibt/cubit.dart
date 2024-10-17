import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop/login_model.dart';
import 'package:flutter_application_1/modules/shop_app/register/cuibt/states.dart';
import 'package:flutter_application_1/shared/remote/dio_helper.dart';
import 'package:flutter_application_1/shared/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCuibt extends Cubit<ShopRegisterStates> {
  ShopRegisterCuibt() : super(ShopRegisterintinalstate());
  static ShopRegisterCuibt get(context) => BlocProvider.of(context);

  late ShopLoginModel? userLogin;

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(ShopRegisterloadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name':name,
      'email': email,
      'password': password,
      'phone':phone,
    }).then((value) {
      print(value.data);
      userLogin = ShopLoginModel.fromJson(value.data);
      // print(RegisterModel.message);
      emit(ShopRegisterSuccessState(userLogin!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  bool ispassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changepassword() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility_off : Icons.visibility_outlined;
    emit(ShopRegisterChangePasswordState());
  }
}
