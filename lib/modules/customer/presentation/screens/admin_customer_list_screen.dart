import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/customer/presentation/screens/cubit/admin_customer_list_cubit.dart';

@RoutePage()
class AdminCustomerListScreen extends StatelessWidget {
  const AdminCustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AdminCustomerListCubit>()..getAllCustomer(),
      child: Scaffold(
        appBar: const SGAppBar(pageTitle: "List Pelanggan"),
        body: BlocBuilder<AdminCustomerListCubit, AdminCustomerListState>(
          builder: (context, state) => switch (state) {
            AdminCustomerListSuccess() =>
              _Content(profiles: state.customerList),
            AdminCustomerListError() =>
              Center(child: SGError(message: state.message)),
            AdminCustomerListLoading() => const SGLoadingOverlay()
          },
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final List<CustomerProfile> profiles;
  const _Content({required this.profiles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final data = profiles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: InkWell(
              onTap: () {
                context.router.push(CustomerProfileRoute(userId: data.id));
              },
              child: ListTile(
                leading: _Profile(data.nama),
                title: Text(data.nama),
                subtitle: Text(data.phoneNumber),
              ),
            ),
          );
        });
  }
}

class _Profile extends StatelessWidget {
  final String name;
  const _Profile(this.name);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        backgroundColor: context.color.primary,
        child: AutoSizeText(
          name.characters.first,
          style: context.text.titleMedium?.copyWith(
              color: context.color.onPrimary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
