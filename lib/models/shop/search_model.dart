class SearchModel {
  late bool status;
  Null message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    message = json['message'];
    (data = json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  late int currentPage;
  late List<Product> data;
  String? firstPageUrl;
  late int from;
  late int lastPage;
  late String lastPageUrl;
  Null nextPageUrl;
  late String path;
  late int perPage;
  Null prevPageUrl;
  late int to;
  late int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page']??0;
    if (json['data'] != null) {
      // ignore: unnecessary_new
      // data = new List<Product>();
      json['data'].forEach((v) {
        data.add(new Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url']??'';
    from = json['from']??0;
    lastPage = json['last_page']??0;
    lastPageUrl = json['last_page_url']??'';
    nextPageUrl = json['next_page_url']??'';
    path = json['path']??'';
    perPage = json['per_page']??0;
    prevPageUrl = json['prev_page_url'];
    to = json['to']??0;
    total = json['total']??0;
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    price = json['price']??0;
    oldPrice = json['old_price']??0;
    discount = json['discount']??0;
    image = json['image']??'';
    name = json['name']??'';
    description = json['description']??'';
  }
  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
