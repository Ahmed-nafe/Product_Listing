import 'package:elvate/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Model/ProductModel.dart';
import '../Network/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());
      List<ProductModel> products = await ProductRepository.getHttp();
      emit(ProductLoaded(products));
    } on Exception catch (e) {
      emit(
        ProductError(e.toString()),
      );
    }
  }
}
