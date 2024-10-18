import 'package:dio/dio.dart';
import 'package:elvate/Model/ProductModel.dart';

class ProductRepository {
  static Future<List<ProductModel>> getHttp() async {
    final response = await Dio().get('https://fakestoreapi.com/products');
    try {
      if (response.statusCode == 200) {
        List<ProductModel> products = (response.data as List)
            .map((items) => ProductModel.fromJson(items))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } on Exception catch (e) {
      throw Exception('Error: $e');
    }
  }
}
