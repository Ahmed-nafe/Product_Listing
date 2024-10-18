
import '../Model/ProductModel.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  ProductLoaded(this.products);
}
class ProductError extends ProductState {
  String error;
  ProductError(this.error);
}
