import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';
import 'package:service_go/modules/customer/domain/model/customer_profile.dart';
import 'package:service_go/modules/customer/presentation/cubits/cubit/customer_profile_cubit.dart';
import 'package:service_go/modules/profile/presentation/screens/customer_profile/cubit/customer_profile_cubit.dart';
import 'package:sizer/sizer.dart';

part 'widget/profile_pic.dart';
part 'widget/user_data.dart';
part 'widget/profile.dart';
part 'widget/section_wrapper.dart';

@RoutePage()
class CustomerProfileScreen extends StatelessWidget {
  final String userId;
  const CustomerProfileScreen(
      {super.key, @PathParam("id") required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CustomerProfileScreenCubit>()..getCustomerProfile(userId),
      child: Scaffold(
        appBar: SGAppBar(
          pageTitle: "Profil",
          actions: [
            if (userId == context.userSession.userId)
              SGAppBarItemAction.icon(
                  icon: Icons.logout,
                  onTap: () {
                    context.logout();
                  })
          ],
        ),
        body:
            BlocBuilder<CustomerProfileScreenCubit, CustomerProfileScreenState>(
          builder: (context, state) => switch (state) {
            CustomerProfileScreenSuccess() => _Content(
                profile: state.customerProfile,
              ),
            CustomerProfileScreenError() => SGError(
                message: state.message,
                retry: state.refresh,
              ),
            CustomerProfileScreenLoading() => const SGLoadingOverlay()
          },
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final CustomerProfile profile;
  const _Content({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: RefreshIndicator(
        onRefresh: () async => context.read<CustomerProfileScreenCubit>()
          ..getCustomerProfile(profile.id),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ProfilePic(profile.nama),
                18.verticalSpace,
                _UserData(userData: context.userSession.userData),
                24.verticalSpace,
                _Profile(
                  profile: profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
