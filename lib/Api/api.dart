import 'dart:convert';

import 'package:asmaasuperadmin/Modules/section_model.dart';
import 'package:asmaasuperadmin/utils/Constants/const.dart';

import 'package:http/http.dart' as http;

class ServData {
  static Future<String?> addSections({required String name}) async {
    String baseUrl = root + 'add.php';
    var map = {'action': 'ADD_SECTION', 'name': name};
    try {
      var response = await http.post(Uri.parse(baseUrl), body: map);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<String?> addCategories(
      {required String name,
      required String  description,
      required String  productNum ,
      required String  purchasePrice,
      required String  sellingPrice,
      required String  wholesalePrice,
      required String  installmentPrice,
      required String  productCode,
      required int sectionId}) async {
    String baseUrl = root + 'add.php';
    var map = {
     'action': 'ADD_PRODUCTS',
     'name': jsonEncode(name),
     'description':jsonEncode(description),
     'productNum': jsonEncode(productNum) ,
     'purchasePrice' : jsonEncode(purchasePrice),
     'sellingPrice' : jsonEncode(sellingPrice),
     'wholesalePrice': jsonEncode(wholesalePrice),
     'installmentPrice': jsonEncode(installmentPrice),
     'productCode': jsonEncode(productCode),
     'sectionId' :jsonEncode(sectionId)
    };

    var response = await http.post(Uri.parse(baseUrl), body: map);
    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      return null;
    }
  }

  static Future<List<Sections>> getSections() async {
    String baseUrl = root + 'get.php?action=GET_ALL_SECTION';
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return sectionsFromJson(response.body);
    } else {
      return [];
    }
  }
}
