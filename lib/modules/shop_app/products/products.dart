import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/cuibt.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/state.dart';
import 'package:flutter_application_1/models/shop/categories_model.dart';
import 'package:flutter_application_1/models/shop/home_model.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesSuccessState) {
          if (!state.model.status) {
            showToast(text: state.model.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) => prodcutsBuilder(
              ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!,
              context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget prodcutsBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data?.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cateogries',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCateogiresItem(
                            categoriesModel.data!.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 20,
                            ),
                        itemCount: categoriesModel.data!.data.length),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'New Prodcuts',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey,
              child: GridView.count(
                shrinkWrap: true,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 4.0,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.0 / 1.50,
                crossAxisCount: 2,
                children: List.generate(
                    model.data!.products.length,
                    (index) => buildGrideProduct(
                        model.data!.products[index], context)),
              ),
            )
          ],
        ),
      );

  Widget buildGrideProduct(
    ProductModel model,
    context,
  ) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                  // fit: BoxFit.cover,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(height: 1.3, fontSize: 12.0),
                  ),
                  Row(
                    children: [
                      Text(
                        'price: ${model.price.round()}',
                        style: TextStyle(
                            height: 1.3, fontSize: 15.0, color: defaultColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                            height: 1.3,
                            fontSize: 12.0,
                            color: Colors.black,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            print(model.id);
                          },
                          icon: Icon(
                            // Icons.favorite_border_outlined,
                            ShopCubit.get(context).favorites[model.id]!
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            size: 20,
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget buildCateogiresItem(DataModel model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 100,
            height: 100,
          ),
          Container(
              width: 100,
              color: Colors.black,
              child: Text(model.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ))),
        ],
      );
}
