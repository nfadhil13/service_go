import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/utils/sg_intents.dart';
import 'package:service_go/infrastructure/widgets/buttons/button_icon_type.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/buttons/outlined_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/image/image_preview.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/layouts/bottomsheet/bottom_sheet_container.dart';
import 'package:service_go/infrastructure/widgets/loading/circular.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/presentation/cubits/bengkel_list/bengkel_list_cubit.dart';
import 'package:service_go/modules/bengkel/presentation/screens/bengkel_list/cubit/bengkel_list_screen_cubit.dart';
import 'package:service_go/modules/bengkel/presentation/widgets/bengkel_list/bengkel_list_widget.dart';
import 'package:service_go/modules/service/presentation/screens/customer_form/customer_servis_form_screen.dart';
import 'package:sizer/sizer.dart';

part 'widgets/bengkel_list.dart';
part 'widgets/map.dart';

@RoutePage()
class BengkelListScreen extends StatelessWidget {
  const BengkelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BengkelListCubit>()
        ..getBengkelList(
            query: SGDataQuery(
                locationQuery: SGLocationQuery(
                    field: "lokasi",
                    radius: 20,
                    center: context.currentLocation.latLgn))),
      child: Scaffold(
        appBar: const SGAppBar(
          pageTitle: "Daftar Bengkel",
        ),
        body: SafeArea(
          child: BlocBuilder<BengkelListCubit, BengkelListState>(
              builder: (context, state) => switch (state) {
                    BengkelListSuccess() => BlocProvider(
                        create: (context) => BengkelListScreenCubit(
                            BengkelListScreenCubitState(
                                null, state.bengkelList)),
                        child: Stack(
                          children: [
                            SizedBox(
                                height: 60.h,
                                child: _Map(
                                  bengkelList: state.bengkelList,
                                )),
                            const SizedBox.expand(
                                child: _BengkelListBottomSheet())
                          ],
                        ),
                      ),
                    BengkelListError() =>
                      SGError(message: state.exception.message),
                    BengkelListLoading() => const SGLoadingOverlay()
                  }),
        ),
      ),
    );
  }
}
