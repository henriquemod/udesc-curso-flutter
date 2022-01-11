class Product {
  late int id;
  late String name;
  late int categoryId;
  late double value;
  double? latitude;
  double? longitude;
  String? customThumbBase64;

  Product(
      {required this.name,
      required this.categoryId,
      required this.value,
      this.customThumbBase64});

  Product.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    value = json['value'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    customThumbBase64 = json['custom_thumb_base64'];
  }
}
