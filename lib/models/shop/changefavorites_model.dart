class ChangefavoritesModel {
  late bool status;
  late String message;

  ChangefavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
