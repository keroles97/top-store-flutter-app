import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../core/i18n/app_string.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/routes.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../../domain/entity/user.dart';
import '../../resource/size_manager.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppSize.marginHeightExtraLarge,
        horizontal: AppSize.marginWidthSmall,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!ServiceLocator.isRegistered<User>())
            InkWell(
                onTap: () {
                  AppNavigator.push(context, Routes.routeLogin);
                },
                child: Text(AppString.login.i18n())),
        ],
      ),
    );
  }
}
