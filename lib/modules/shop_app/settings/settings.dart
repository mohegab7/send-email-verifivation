import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/cuibt.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/state.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSettings extends StatelessWidget {
  var fromkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var model = ShopCubit.get(context).userModel;
          nameController.text = model!.data.name;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;
          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: fromkey,
                child: Column(
                  children: [
                    if (state is ShopUpdateUserDataLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must not empty';
                        }
                        return null;
                      },
                      label: 'name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController as TextEditingController,
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email must not empty';
                        }
                        return null;
                      },
                      label: 'email',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController as TextEditingController,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not empty';
                        }
                        return null;
                      },
                      label: 'phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        text: 'log out',
                        function: () {
                          Singout(context);
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        text: 'Update',
                        function: () {
                          if (fromkey.currentState!.validate()) {
                            ShopCubit.get(context).UpdateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        }),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {});
  }
}
