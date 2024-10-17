import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/cuibt/cuibt.dart';
import 'package:flutter_application_1/layout/social_app/cuibt/states.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SoicalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCuibt, SocialStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('News Feed'),
            ),
            body: ConditionalBuilder(
              condition: state is SocialGetUserSuccessState != null
              // true
              ,
              builder: (context) {
                var model = SocialCuibt.get(context).model;
                return Column(
                  children: [
                    if (!FirebaseAuth.instance.currentUser!.emailVerified)
                      Container(
                          color: Colors.amber.withOpacity(0.6),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
                                Icon(Icons.info_outline_rounded),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Text(
                                  'send verify email',
                                  style: TextStyle(fontSize: 20),
                                )),
                                SizedBox(
                                  width: 20,
                                ),
                                defaultTextbutton(
                                    function: () {
                                      FirebaseAuth.instance.currentUser!
                                          .sendEmailVerification()
                                          .then((value) {
                                        showToast(
                                            text: 'check your email',
                                            state: ToastStates.SUCCES);
                                      }).catchError((error) {});
                                    },
                                    text: 'send',
                                    size: 20)
                              ],
                            ),
                          ))
                  ],
                );
              },
              fallback: (BuildContext context) =>
                  Center(child: CircularProgressIndicator()),
            ),
          );
        },
        listener: (context, state) {});
  }
}
