class ProductModel {
  int? id;
  int? catid;
  String? productname;
  double? price;
  String? image;
  String? description;

  ProductModel({
    this.id,
    this.catid,
    this.productname,
    this.price,
    this.image,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        catid: json["catid"],
        productname: json["productname"],
        price: json["price"]?.toDouble(),
        image: json["image"],
        description: json["description"],
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "catid": catid,
  //       "productname": productname,
  //       "price": price,
  //       "image": image,
  //       "description": description,
  //     };
}
