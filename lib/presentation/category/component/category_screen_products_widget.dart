import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:store/domain/entity/product.dart';
import 'package:store/presentation/category/component/category_screen_load_more_widget.dart';
import 'package:store/presentation/resource/component/ratingbar_widget.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/theme/app_style.dart';
import '../../../core/util/app_constant.dart';
import '../../resource/component/spacer_widget.dart';
import '../../resource/size_manager.dart';

class CategoryScreenProductsWidget extends StatelessWidget {
  final int categoryId;
  final List<Product> products;

  const CategoryScreenProductsWidget(
      {Key? key, required this.products, required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int productsLen = products.length;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: productsLen + 1,
      itemBuilder: (context, i) {
        if (i < productsLen) return _productCard(context, i);

        /// its last item so add (load more view)
        return CategoryScreenLoadMoreWidget(
          categoryId: categoryId,
          productsLen: productsLen,
        );
      },
    );
  }

  Widget _productCard(BuildContext context, int i) {
    return InkWell(
      onTap: () => _productClick(context, products[i].id),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.paddingWidthDoubleExtraSmall,
            vertical: AppSize.paddingHeightDoubleExtraSmall,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                width: AppSize.width2,
                height: AppSize.width2,
                imageUrl: products[i].images.first,
                fit: BoxFit.contain,
              ),
              SpacerWidget(
                width: AppSize.width0_02,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    products[i].name,
                    textAlign: TextAlign.center,
                  ),
                  SpacerWidget(
                    height: AppSize.height0_01,
                  ),
                  RatingbarWidget(
                    rating: products[i].rating,
                    ratersCount: products[i].ratersCount,
                  ),
                  SpacerWidget(
                    height: AppSize.height0_01,
                  ),
                  Visibility(
                    visible: products[i].discountedPrice > AppConstant.zeroDol,
                    child: Text(
                      products[i].price.toString() + AppConstant.dollarSign,
                      style: AppStyle.textRegular(
                        color: AppColor.disabled,
                        size: AppSize.fontLarge,
                      ).copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                  SpacerWidget(height: AppSize.height0_01),
                  Visibility(
                    visible: products[i].discountedPrice > AppConstant.zeroDol,
                    replacement: Text(
                      products[i].price.toString() + AppConstant.dollarSign,
                      style: AppStyle.textBold(
                        color: AppColor.primary,
                        size: AppSize.fontExtraLarge,
                      ),
                    ),
                    child: Text(
                      products[i].discountedPrice.toString() +
                          AppConstant.dollarSign,
                      style: AppStyle.textBold(
                        color: AppColor.primary,
                        size: AppSize.fontExtraLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _productClick(BuildContext context, int productId) {
    AppNavigator.push(context, Routes.routeProduct, data: {'id': productId});
  }
}
