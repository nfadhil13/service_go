import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/dynamic_ext.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/widgets/layouts/bottomsheet/bottom_sheet_container.dart';
import 'package:service_go/modules/bengkel/presentation/cubits/bengkel_list/bengkel_list_cubit.dart';
import 'package:service_go/modules/bengkel/presentation/widgets/bengkel_list/bengkel_list_widget.dart';
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
        body: Stack(
          children: [
            SizedBox(height: 60.h, child: const _Map()),
            const SizedBox.expand(child: _BengkelList())
          ],
        ),
      ),
    );
  }
}
