import 'package:flutter_application_1/models/shop/search_model.dart';
import 'package:flutter_application_1/modules/shop_app/search/cuibt/states.dart';
import 'package:flutter_application_1/shared/components/constants.dart';
import 'package:flutter_application_1/shared/remote/dio_helper.dart';
import 'package:flutter_application_1/shared/remote/end_points.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCuibt extends Cubit<SearchStates> {
  SearchCuibt() : super(SearchIntinalstate());
  static SearchCuibt get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search(String text) {
    emit(SearchloadingState());
    DioHelper.postData(data: {'text': text}, url: SEARCH, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
