import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/shoplayout.dart';
import 'package:flutter_application_1/modules/shop_app/register/cuibt/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/register/cuibt/states.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_application_1/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegister extends StatelessWidget {
  var namecontroll = TextEditingController();
  var phonecontroll = TextEditingController();
  var emailcontroll = TextEditingController();
  var passwordcontroll = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCuibt(),
      child: BlocConsumer<ShopRegisterCuibt, ShopRegisterStates>(
        builder: (BuildContext context, ShopRegisterStates state) {
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
                            'REGISTER now to browse',
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
                            suffix: ShopRegisterCuibt.get(context).suffix,
                            onSubmit: (value) {},
                            isPassword:
                                ShopRegisterCuibt.get(context).ispassword,
                            suffixPressed: () {
                              ShopRegisterCuibt.get(context).changepassword();
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
                              condition: state is! ShopRegisterloadingState,
                              builder: (context) => defaultButton(
                                  text: 'Register',
                                  isUppercase: true,
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      ShopRegisterCuibt.get(context)
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
           if (state is ShopRegisterSuccessState) {
              if (state.loginModel.status) {
                // print(state.loginModel.message);
                // print(state.loginModel.data.token);
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data.token)
                    .then((value) {
                  token = state.loginModel.data.token;
                  NavigateAndFinish(
                    context,
                    Shoplayout(),
                  );
                });
              } else {
                print(state.loginModel.message);
                showToast(
                    text: state.loginModel.message, state: ToastStates.ERROR);
              }
            }
        },
      ),
    );
  }
}
