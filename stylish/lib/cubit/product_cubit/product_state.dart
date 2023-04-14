// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ProductState {}

class ProductInitial extends ProductState {}

class GetProductsSuccessState extends ProductState {}

class GetProductsLoadingState extends ProductState {}

class GetProductsFailureState extends ProductState {

  final String? errorMessage;

  GetProductsFailureState([this.errorMessage]);
  
}

class ShowLoadingState extends ProductState {}
