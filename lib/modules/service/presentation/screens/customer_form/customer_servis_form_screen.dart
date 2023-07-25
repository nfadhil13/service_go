import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/widgets/buttons/button_icon_type.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/buttons/outlined_button.dart';
import 'package:service_go/infrastructure/widgets/form/date_time_picker.dart';
import 'package:service_go/infrastructure/widgets/form/multi_select.dart';
import 'package:service_go/infrastructure/widgets/form/text_field.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';
import 'package:service_go/infrastructure/widgets/image/image_preview.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:sizer/sizer.dart';

part 'widgets/selected_bengkel.dart';
part 'widgets/form.dart';
part 'widgets/button.dart';

sealed class CustomerServisFormScreenMode {}

@RoutePage()
class CustomerServisFormScreen extends StatelessWidget {
  final BengkelProfile bengkel;
  const CustomerServisFormScreen({super.key, required this.bengkel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SGAppBar(
        pageTitle: "Pesan Servis Motor",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 2.5.h),
              child: Column(
                children: [
                  _SelectedBengkel(profile: bengkel),
                  3.h.verticalSpace,
                  _Form(
                    profile: bengkel,
                  ),
                  3.h.verticalSpace
                ],
              ),
            ),
          ),
          SizedBox.expand(
              child: Container(
            alignment: Alignment.bottomCenter,
            child: const _Button(),
          ))
        ],
      ),
    );
  }
}
