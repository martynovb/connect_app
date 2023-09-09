class CategoryApiModel {
  final String? title;

  CategoryApiModel({required this.title});

  static CategoryApiModel fromJson(Map<dynamic, dynamic> json) {
    return CategoryApiModel(title: json['title'] as String?);
  }
}
