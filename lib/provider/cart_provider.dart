import 'dart:developer';

import 'package:ecommerce_bootcampapp/models/product_model.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  final List<CartProduct> _list = [];
  List<CartProduct> get getItems {
    return _list;
  }

  double get totalPrice {
    var total = 0.0;

    for (var item in _list) {
      total = total + (item.price * item.qty);
    }
    return total;
  }

  int? get count {
    return _list.length;
  }

  void addItem(
    int id,
    String name,
    double price,
    int qty,
    String imagesUrl,
  ) {
    final product = CartProduct(
      id: id,
      name: name,
      price: price,
      qty: qty,
      imagesUrl: imagesUrl,
    );
    _list.add(product);
    notifyListeners();
    log("add product  !!!!!!!!!!!!!!!");
  }

  void increment(CartProduct product) {
    product.increase();
    notifyListeners();
  }

  void reduceByOne(CartProduct product) {
    product.decrease();
    notifyListeners();
  }

  void removeItem(CartProduct product) {
    _list.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _list.clear();
    notifyListeners();
  }
}

class CartProduct {
  int id;
  String name;
  double price;
  int qty = 1;
  String imagesUrl;

  CartProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.imagesUrl,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        imagesUrl: json["image"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": imagesUrl,
        "qty": qty,
      };
  void increase() {
    qty++;
    //  qty = qty + 1;
  }

  void decrease() {
    qty--;
    //qty = qty - 1;
  }
}
