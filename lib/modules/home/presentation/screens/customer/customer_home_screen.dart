import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/architecutre/cubits/location/location_cubit.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/widgets/icons/text.dart';
import 'package:service_go/infrastructure/widgets/map/map_picker.dart';
import 'package:service_go/modules/bengkel/presentation/widgets/bengkel_list/bengkel_list_widget.dart';
import 'package:service_go/modules/customer/presentation/cubits/cubit/customer_profile_cubit.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/presentation/widgets/list/servis_list_widget.dart';
import 'package:sizer/sizer.dart';

part 'widgets/app_bar.dart';
part 'widgets/bengkel_terdekat.dart';
part 'widgets/current_location.dart';
part 'widgets/servis_berjalan.dart';

@RoutePage()
class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _HomeAppBar(),
            2.h.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: const _CurrentLocation(),
            ),
            5.h.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              child: Column(
                children: [
                  const _ServisBerjalan(),
                  4.h.verticalSpace,
                  const _BengkelTerdekatSection()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
