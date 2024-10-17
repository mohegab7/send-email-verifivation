import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/layout/social_app/cuibt/states.dart';
import 'package:flutter_application_1/models/social_app/social_app_model.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCuibt extends Cubit<SocialStates> {
  SocialCuibt() : super(SocialIntinalstate());
  static SocialCuibt get(context) => BlocProvider.of(context);

   SocialUserModel? model;

  void getUserdata() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }
}
