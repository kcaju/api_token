import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:token_test/model/product_model.dart';
import 'package:token_test/utils/app_utils.dart';

class HomeController with ChangeNotifier {
  bool isLoading = false;
  //varaible to store product list
  List<ProductModel>? productList = [];
  Future<void> getProducts() async {
    isLoading = true;
    notifyListeners();
    //setup url
    final url = Uri.parse("https://freeapi.luminartechnohub.com/products-all/");

    try {
      //call api
      final response = await http.get(url, headers: {
        "Authorization": "Bearer ${await AppUtils.getStoredAccessToken()}"
      });
      log(response.body);
      //check status code
      if (response.statusCode == 200) {
        //convert code
        ProductsResModel resModel = productsResModelFromJson(response.body);
        //store data to model
        productList = resModel.data ?? [];
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
