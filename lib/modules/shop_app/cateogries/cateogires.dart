import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/cuibt.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/state.dart';
import 'package:flutter_application_1/models/shop/categories_model.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCateogires extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length);
        },
        listener: (context, state) {});
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined),
          ],
        ),
      );
}
