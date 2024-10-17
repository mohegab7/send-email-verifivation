import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/social_app/social_app_model.dart';
import 'package:flutter_application_1/modules/social_app/social_register/cuibt/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCuibt extends Cubit<SocialRegisterStates> {
  SocialRegisterCuibt() : super(SocialRegisterintinalstate());
  static SocialRegisterCuibt get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(SocialRegisterloadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value.user?.email);
      // print(value.user?.uid);
      userCreate(email: email, name: name, phone: phone, uId: value.user!.uid);
      // emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((Error) {
      emit(SocialCreateUserErrorState(Error.toString()));
    });
  }

  bool ispassword = true;
  IconData suffix = Icons.visibility_outlined;
  void changepassword() {
    ispassword = !ispassword;
    suffix = ispassword ? Icons.visibility_off : Icons.visibility_outlined;
    emit(SocialRegisterChangePasswordState());
  }
}
