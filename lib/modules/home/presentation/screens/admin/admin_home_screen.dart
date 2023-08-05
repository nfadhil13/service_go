import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/home/presentation/screens/admin/cubit/admin_home_screen_cubit.dart';
import 'package:service_go/modules/service/presentation/screens/list/servist_list_screen.dart';

@RoutePage()
class AdmminHomeScreen extends StatelessWidget {
  const AdmminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminHomeScreenCubit>()..prepare(),
      child: Scaffold(
        appBar: SGAppBar(
          pageTitle: "Admin Home",
          actions: [
            SGAppBarItemAction.icon(
                icon: Icons.logout, onTap: () => context.logout())
          ],
        ),
        body: BlocBuilder<AdminHomeScreenCubit, AdminHomeScreenState>(
          builder: (context, state) => switch (state) {
            AdminHomeScreenSuccess() => SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Column(
                    children: [
                      _HomeItem(
                          title: "Data Bengkel",
                          onTap: () {
                            context.router.push(const AdminBengkelListRoute());
                          },
                          count: state.bengkelCount,
                          icon: Icons.settings),
                      24.verticalSpace,
                      _HomeItem(
                          title: "Data Customer",
                          count: state.customerCount,
                          icon: Icons.person),
                      24.verticalSpace,
                      _HomeItem(
                          title: "Data Servis",
                          onTap: () {
                            context.router.push(
                                ServisListRoute(onServisClick: (servis, _) {
                              context.router.push(ServisCustomerDetailRoute(
                                  servisId: servis.id.id!));
                            }));
                          },
                          count: state.servisCount,
                          icon: Icons.room_service)
                    ],
                  ),
                ),
              ),
            AdminHomeScreenError() => Center(
                  child: SGError(
                message: state.message,
                retry: () => context.read<AdminHomeScreenCubit>().prepare(),
              )),
            AdminHomeScreenLoading() => const SGLoadingOverlay()
          },
        ),
      ),
    );
  }
}

class _HomeItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final int count;
  final IconData icon;
  const _HomeItem(
      {super.key,
      this.onTap,
      required this.title,
      required this.count,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
            border: Border.all(
              color: color.outline,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  12.verticalSpace,
                  Text("Jumlah : $count")
                ],
              ),
            ),
            14.horizontalSpace,
            Icon(icon)
          ],
        ),
      ),
    );
  }
}
