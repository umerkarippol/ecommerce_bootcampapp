class OrderModel {
  int id;
  String username;
  double totalamount;
  String paymentmethod;
  DateTime date;
  List<Product> products;

  OrderModel({
    required this.id,
    required this.username,
    required this.totalamount,
    required this.paymentmethod,
    required this.date,
    required this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        username: json["username"],
        totalamount: json["totalamount"]?.toDouble(),
        paymentmethod: json["paymentmethod"],
        date: DateTime.parse(json["date"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "totalamount": totalamount,
        "paymentmethod": paymentmethod,
        "date": date.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String productname;
  double price;
  String image;
  int quantity;

  Product({
    required this.productname,
    required this.price,
    required this.image,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productname: json["productname"],
        price: json["price"]?.toDouble(),
        image: json["image"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productname": productname,
        "price": price,
        "image": image,
        "quantity": quantity,
      };
}
