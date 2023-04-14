
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/cubit/product_cubit/product_state.dart';
import 'package:stylish/data/repository/product_repository.dart';
import 'package:stylish/data/source/server/api_result_handler.dart';
import 'package:stylish/models/products_model.dart';

class ProcuctCubit extends Cubit<ProductState> {
  ProcuctCubit() : super(ProductInitial());

  Products products = Products();
  int nextPaging = 1;
  bool isLoading = false;
  void getAllProducts(int page) async {
    if (nextPaging == 1) {
      emit(GetProductsLoadingState());
    }
    isLoading = true;
    if (isLoading) {
      emit(ShowLoadingState());
    }

    ApiResults apiResults = await ProductReposiroty().getAllProducts();

    if (apiResults is ApiSuccess) {
      handelProductsResponse(apiResults.data);
    } else if (apiResults is ApiFailure) {
      emit(GetProductsFailureState(apiResults.message));
    }
  }

  void handelProductsResponse(json) {
    if (nextPaging == 1) {
      products = Products.fromJson(json);
    } else if (nextPaging > 1) {
      Products temProducts = Products();
      temProducts = Products.fromJson(json);
      products.data?.addAll(temProducts.data as Iterable<Datum>);
    }
    nextPaging++;
    isLoading = false;
    emit(GetProductsSuccessState());
  }
}
