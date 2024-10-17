import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/social_app/social_login/cuibt/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCuibt extends Cubit<SocialLoginStates> {
  SocialLoginCuibt() : super(SocialLoginintinalstate());
  static SocialLoginCuibt get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginloadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  bool ispassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changepassword() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility_off : Icons.visibility_outlined;
    emit(SocialChangePasswordState());
  }
}
