import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/social_app/soical_layout.dart';
import 'package:flutter_application_1/modules/social_app/social_login/cuibt/cubit.dart';
import 'package:flutter_application_1/modules/social_app/social_login/cuibt/states.dart';
import 'package:flutter_application_1/modules/social_app/social_register/social_register.dart';

import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  var emailcontroll = TextEditingController();
  var passwordcontroll = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCuibt(),
      child: BlocConsumer<SocialLoginCuibt, SocialLoginStates>(
          builder: (context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'login now to commuicate with friends',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: emailcontroll,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('email is empty');
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultFormField(
                          controller: passwordcontroll,
                          label: 'password',
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock,
                          suffix: SocialLoginCuibt.get(context).suffix,
                          onSubmit: (value) {
                            if (formkey.currentState!.validate()) {
                              SocialLoginCuibt.get(context).userLogin(
                                email: emailcontroll.text,
                                password: passwordcontroll.text,
                              );
                            }
                          },
                          isPassword: SocialLoginCuibt.get(context).ispassword,
                          suffixPressed: () {
                            SocialLoginCuibt.get(context).changepassword();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('password is not correct');
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                            condition: true,
                            builder: (context) => LoginButton(
                                background: Colors.blue,
                                radius: 20.0,
                                function: () {
                                  if (formkey.currentState!.validate()) {
                                    SocialLoginCuibt.get(context).userLogin(
                                      email: emailcontroll.text,
                                      password: passwordcontroll.text,
                                    );
                                  }
                                }),
                            fallback: (Contexr) =>
                                Center(child: CircularProgressIndicator())),
                        Row(
                          children: [
                            Text(
                              "Don't have an account",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            defaultTextbutton(
                                function: () {
                                  Navigateto(context, SocialRegister());
                                },
                                text: 'register',
                                color: defaultColor)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }, listener: (context, state) {
        if (state is SocialLoginErrorState) {
          showToast(text: state.error, state: ToastStates.ERROR);
        }
        if(state is SocialLoginSuccessState){
          CacheHelper.saveData(key:'uId' , value:state.uId ).then((value){
            NavigateAndFinish(context, SoicalLayout());
          });
        }
      }),
    );
  }
}
