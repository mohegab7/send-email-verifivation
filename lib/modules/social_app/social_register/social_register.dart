import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/layout/social_app/soical_layout.dart';
import 'package:flutter_application_1/modules/social_app/social_login/social_login_screen.dart';
import 'package:flutter_application_1/modules/social_app/social_register/cuibt/cubit.dart';
import 'package:flutter_application_1/modules/social_app/social_register/cuibt/states.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegister extends StatelessWidget {
  var namecontroll = TextEditingController();
  var phonecontroll = TextEditingController();
  var emailcontroll = TextEditingController();
  var passwordcontroll = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCuibt(),
      child: BlocConsumer<SocialRegisterCuibt, SocialRegisterStates>(
        builder: (BuildContext context, SocialRegisterStates state) {
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
                            'REGISTER',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'REGISTER now to commuicate with friends',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: namecontroll,
                            type: TextInputType.name,
                            label: 'User Name',
                            prefix: Icons.person,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('User Name is empty');
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.0),
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
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: passwordcontroll,
                            label: 'password',
                            type: TextInputType.visiblePassword,
                            prefix: Icons.lock,
                            suffix: SocialRegisterCuibt.get(context).suffix,
                            onSubmit: (value) {},
                            isPassword:
                                SocialRegisterCuibt.get(context).ispassword,
                            suffixPressed: () {
                              SocialRegisterCuibt.get(context).changepassword();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('password is empty');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller: phonecontroll,
                            type: TextInputType.phone,
                            label: 'phone',
                            prefix: Icons.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('phone is empty');
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                              condition: state is! SocialRegisterloadingState,
                              builder: (context) => defaultButton(
                                  text: 'Register',
                                  isUppercase: true,
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      SocialRegisterCuibt.get(context)
                                          .userRegister(
                                        email: emailcontroll.text,
                                        password: passwordcontroll.text,
                                        name: namecontroll.text,
                                        phone: phonecontroll.text,
                                      );
                                    }
                                  }),
                              fallback: (Contexr) =>
                                  Center(child: CircularProgressIndicator())),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            Navigateto(context, SocialLoginScreen());
          }
        },
      ),
    );
  }
}
