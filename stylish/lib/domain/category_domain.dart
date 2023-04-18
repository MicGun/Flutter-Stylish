enum ProductCategoryType { women, men, accessories, }

ProductCategoryType getProductCategoryType(String categoryString) {
  switch (categoryString) {
    case 'women':
      return ProductCategoryType.women;
    case 'men':
      return ProductCategoryType.men;
    case 'accessories':
      return ProductCategoryType.accessories;
    default:
      return ProductCategoryType.accessories;
  }
}

extension ProductCategoryTypeExtension on ProductCategoryType {
  String getProductCategoryTypeValue() {
    switch (this) {
      case ProductCategoryType.women:
        return 'women';
      case ProductCategoryType.men:
        return 'men';
      case ProductCategoryType.accessories:
        return 'accessories';
    }
  }

  String getProductCategoryTypeName() {
    switch (this) {
      case ProductCategoryType.women:
        return '女裝';
      case ProductCategoryType.men:
        return '男裝';
      case ProductCategoryType.accessories:
        return '配件';
    }
  }
}
