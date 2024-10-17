import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_app/cuibt/state.dart';
import 'package:flutter_application_1/models/shop/categories_model.dart';
import 'package:flutter_application_1/models/shop/home_model.dart';
import 'package:flutter_application_1/models/shop/login_model.dart';
import 'package:flutter_application_1/modules/shop_app/cateogries/cateogires.dart';
import 'package:flutter_application_1/modules/shop_app/favorites/favorites.dart';
import 'package:flutter_application_1/modules/shop_app/products/products.dart';
import 'package:flutter_application_1/modules/shop_app/settings/settings.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_application_1/shared/remote/dio_helper.dart';
import 'package:flutter_application_1/shared/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int current_index = 0;
  List<Widget> bottomScreens = [
    ShopProducts(),
    ShopCateogires(),
    ShopFavorites(),
    ShopSettings()
  ];
  void ChangeBottom(int index) {
    current_index = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners[0].image);
      // print(homeModel!.status);
      homeModel!.data!.products.forEach((ele) {
        favorites.addAll({ele.id: ele.inFavorites});
      });
      // print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }

  // FavoritesModel? favoritesModel;

  // void getFavorites() {
  //   emit(ShopGetFavoritesLoadingState());
  //   DioHelper.getData(
  //     url: FAVORITES,
  //     token: token,
  //   ).then((value) {
  //     favoritesModel = FavoritesModel.fromJson(value.data);
  //     emit(ShopGetFavoritesSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ShopGetFavoritesErrorState());
  //   });
  // }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopUserDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data.name);
      emit(ShopUserDataSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUserDataErrorState());
    });
  }

  void UpdateUserData({
    required String name,
    required String email,
    required String phone,
    // required String password,
  }) {
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(
      url: UPDATA_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data.name);
      emit(ShopUpdateUserDataSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateUserDataErrorState());
    });
  }

  // ChangefavoritesModel? changefavoritesModel;
  // void changeFavorites(int ProductId) {
  //   favorites[ProductId] = !favorites[ProductId]!;
  //   emit(ShopChangeFavoritesLoadingState());
  //   DioHelper.postData(
  //     data: {'product_id': ProductId},
  //     url: FAVORITES,
  //     token: token,
  //   ).then((value) {
  //     changefavoritesModel = ChangefavoritesModel.fromJson(value.data);
  //     print(value.data);
  //     if (!changefavoritesModel!.status) {
  //       favorites[ProductId] = !favorites[ProductId]!;
  //     } else {
  //       getFavorites();
  //     }
  //     emit(ShopChangeFavoritesSuccessState(changefavoritesModel!));
  //   }).catchError((error) {
  //     favorites[ProductId] = !favorites[ProductId]!;
  //     emit(ShopChangeFavoritesErrorState());
  //   });
  // }
}
