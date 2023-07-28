import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/widgets/filter/filter.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/presentation/screens/list/cubit/servis_list_filter_cubit.dart';
import 'package:service_go/modules/service/presentation/widgets/list/servis_list_widget.dart';
import 'package:sizer/sizer.dart';

class ServisListType {
  final bool isBengkel;
  final String userId;

  ServisListType(this.isBengkel, this.userId);

  SGQueryField get queryField =>
      SGQueryField(isBengkel ? "bengkelId" : "customerId", isEqual: userId);
}

@RoutePage()
class ServisListScreen extends StatelessWidget {
  final SGDataQuery? initialQuery;
  final ServisListType? type;
  final Servis Function(Servis servis)? onServisClick;
  const ServisListScreen(
      {super.key, this.initialQuery, this.onServisClick, this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ServisListFilterCubit>(param1: initialQuery, param2: type),
      child: Scaffold(
        appBar: SGAppBar(
          pageTitle: "Servis",
          actions: [
            if (type?.isBengkel == false)
              SGAppBarItemAction.icon(
                  icon: Icons.add,
                  onTap: () {
                    context.router.push(const BengkelListRoute());
                  })
          ],
        ),
        body: BlocBuilder<ServisListFilterCubit, SGDataQuery>(
          builder: (context, state) {
            final cubit = context.read<ServisListFilterCubit>();
            return SingleChildScrollView(
              child: Column(
                children: [
                  2.h.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                    child: SGFilter(
                      onChange: cubit.applyQuery,
                      filterGroups: cubit.filters,
                    ),
                  ),
                  2.h.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                    child: ServisListAutoWidget(
                      onTap: onServisClick,
                      query: state,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
