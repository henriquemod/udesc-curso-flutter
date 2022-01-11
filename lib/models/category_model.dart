class Category {
  late int id;
  late String thumb;
  late String name;

  Category(this.id, this.thumb, this.name);

  Category.fromMap(Map<String, dynamic> json) {
    id = json['category_id'];
    thumb = json['category_thumb'];
    name = json['category_name'];
  }
}
