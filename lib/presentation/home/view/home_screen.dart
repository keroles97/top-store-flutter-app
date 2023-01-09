import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/theme/app_color.dart';
import 'package:store/core/util/di.dart';
import 'package:store/presentation/home/component/home_screen_carousel_builder_widget.dart';
import 'package:store/presentation/home/component/home_screen_categories_builder_widget.dart';
import 'package:store/presentation/home/component/home_screen_deals_builder_widget.dart';
import 'package:store/presentation/home/controller/home_screen_bloc.dart';

import '../../../core/util/size_manager.dart';
import '../../common/spacer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeScreenBloc>(
        create: (context) {
          return di<HomeScreenBloc>()
            ..add(const HomeScreenGetMainCarouselEvent())
            ..add(const HomeScreenGetMainCategoriesEvent())
            ..add(const HomeScreenGetDealsEvent());
        },
        child: Container(
          color: AppColor.greyDoubleExtraLight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: const [
                    HomeScreenCarouselBuilderWidget(),
                    HomeScreenCategoriesBuilderWidget(),
                  ],
                ),
                SpacerWidget(
                  height: AppSize.height0_03,
                ),
                const HomeScreenDealsBuilderWidget(),
              ],
            ),
          ),
        ));
  }
}