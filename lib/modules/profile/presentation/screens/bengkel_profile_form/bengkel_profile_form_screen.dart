import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/widgets/form/image/image_picker.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:sizer/sizer.dart';

part 'widgets/form.dart';

@RoutePage()
class BengkelProfileFormScreen extends StatelessWidget {
  final BengkelProfile? initial;
  final VoidCallback? onBengkelProfileCreated;
  const BengkelProfileFormScreen(
      {super.key, this.initial, this.onBengkelProfileCreated});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.background,
      appBar: const SGAppBar(
        pageTitle: "Profile",
      ),
      body: const _Form(),
    );
  }
}
