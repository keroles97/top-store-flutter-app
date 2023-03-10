part of 'category_screen_bloc.dart';

class CategoryScreenState extends Equatable {
  final RequestStateEnum getCategoryProductsRequestState;
  final RequestStateEnum loadMoreCategoryProductsRequestState;
  final String getCategoryProductsError;
  final String loadMoreCategoryProductsError;
  final List<Product> products;
  final bool noMoreProducts;
  final Filter filter;

  const CategoryScreenState({
    this.getCategoryProductsRequestState = RequestStateEnum.loading,
    this.loadMoreCategoryProductsRequestState = RequestStateEnum.initializing,
    this.getCategoryProductsError = AppConstant.emptyStr,
    this.loadMoreCategoryProductsError = AppConstant.emptyStr,
    this.products = const [Product.empty()],
    this.noMoreProducts = false,
    this.filter = const Filter.initial(),
  });

  CategoryScreenState copyWith({
    RequestStateEnum? getCategoryProductsRequestState,
    RequestStateEnum? loadMoreCategoryProductsRequestState,
    String? getCategoryProductsError,
    String? loadMoreCategoryProductsError,
    List<Product>? products,
    bool? noMoreProducts,
    Filter? filter,
  }) {
    return CategoryScreenState(
      getCategoryProductsRequestState: getCategoryProductsRequestState
          ?? this.getCategoryProductsRequestState,
      loadMoreCategoryProductsRequestState: loadMoreCategoryProductsRequestState
          ?? this.loadMoreCategoryProductsRequestState,
      getCategoryProductsError: getCategoryProductsError
          ?? this.getCategoryProductsError,
      loadMoreCategoryProductsError: loadMoreCategoryProductsError
          ?? this.loadMoreCategoryProductsError,
      products: products
          ?? this.products,
      noMoreProducts: noMoreProducts
          ?? this.noMoreProducts,
      filter: filter
          ?? this.filter,
    );
  }

  @override
  List<Object> get props => [
        getCategoryProductsRequestState,
        loadMoreCategoryProductsRequestState,
        getCategoryProductsError,
        loadMoreCategoryProductsError,
        products,
        noMoreProducts,
        filter,
      ];
}
