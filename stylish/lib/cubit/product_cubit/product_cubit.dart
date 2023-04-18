
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/cubit/product_cubit/product_state.dart';
import 'package:stylish/data/repository/product_repository.dart';
import 'package:stylish/data/source/server/api_result_handler.dart';
import 'package:stylish/models/products_model.dart';

class ProcuctCubit extends Cubit<ProductState> {
  ProcuctCubit() : super(ProductInitial());

  Products products = Products();
  Products womenProducts = Products();
  Products menProducts = Products();
  Products accessoriesProducts = Products();
  // int nextPaging = 1;
  bool isLoading = false;
  void getAllProducts(int page) async {
    // if (nextPaging == 1) {
    //   emit(GetProductsLoadingState());
    // }
    isLoading = true;
    if (isLoading) {
      emit(ShowLoadingState());
    }

    ApiResults womenResults = await ProductReposiroty().getWomenProducts();
    ApiResults menResults = await ProductReposiroty().getMenProducts();
    ApiResults accessoriesResults = await ProductReposiroty().getAccessoriesProducts();

    if (womenResults is ApiSuccess && menResults is ApiSuccess && accessoriesResults is ApiSuccess) {
      handelProductsResponse(womenResults.data, menResults.data, accessoriesResults.data);
    } else if (womenResults is ApiFailure) {
      emit(GetProductsFailureState(womenResults.message));
    } else if (menResults is ApiFailure) {
      emit(GetProductsFailureState(menResults.message));
    } else if (accessoriesResults is ApiFailure) {
      emit(GetProductsFailureState(accessoriesResults.message));
    }
  }

  void handelProductsResponse(womenJson, menJson, accessoriesJson) {
    // if (nextPaging == 1) {
    //   products = Products.fromJson(json);
    // } else if (nextPaging > 1) {
    //   Products temProducts = Products();
    //   temProducts = Products.fromJson(json);
    //   products.data?.addAll(temProducts.data as Iterable<Datum>);
    // }
    womenProducts = Products.fromJson(womenJson);
    menProducts = Products.fromJson(menJson);
    accessoriesProducts = Products.fromJson(accessoriesJson);
    // nextPaging++;
    isLoading = false;
    emit(GetProductsSuccessState());
  }
}
