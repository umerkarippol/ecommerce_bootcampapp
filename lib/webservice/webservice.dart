import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_bootcampapp/main.dart';
import 'package:ecommerce_bootcampapp/models/category_model.dart';
import 'package:ecommerce_bootcampapp/models/orderdetailmodel.dart';
import 'package:ecommerce_bootcampapp/models/product_model.dart';
import 'package:ecommerce_bootcampapp/models/user_model.dart';
import 'package:http/http.dart' as http;

class Webservice {
  final imageurl = 'http://bootcamp.cyralearnings.com/products/';
  static final mainurl = 'http://bootcamp.cyralearnings.com/';

  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse(mainurl + 'view_offerproducts.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>> fetchCatProducts(int catid) async {
    log("catid ==" + catid.toString());
    final response = await http.post(
        Uri.parse(mainurl + 'get_category_products.php'),
        body: {'catid': catid.toString()});
    log("statuscode==" + response.statusCode.toString());
    if (response.statusCode == 200) {
      log("response == " + response.body.toString());
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load category products');
    }
  }

  Future<List<OrderModel>?> fetchOrderDetails(String username) async {
    try {
      log("username ==" + username.toString());
      final response = await http.post(
          Uri.parse(mainurl + 'get_orderdetails.php'),
          body: {'username': username.toString()});

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      log("order details ==" + e.toString());
    }
  }

  Future<List<CategoryModel>?> fetchCategory() async {
    try {
      final response = await http.get(Uri.parse(mainurl + 'getcategories.php'));

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<CategoryModel>((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load category');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<UserModel?> fetchUser(String username) async {
    try {
      final response = await http.post(Uri.parse(mainurl + 'get_user.php'),
          body: {'username': username});

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load User');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
