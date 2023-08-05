import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/gis/lat_lgn.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/utils/sg_intents.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/error.dart';
import 'package:service_go/infrastructure/widgets/form/map_field.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/infrastructure/widgets/loading/overlay.dart';
import 'package:service_go/modules/authentication/domain/model/user_data.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/model/jadwal_bengkel.dart';
import 'package:service_go/modules/bengkel/presentation/cubits/bengkel_profile/bengkel_profile_cubit.dart';
import 'package:service_go/modules/profile/presentation/screens/bengkel_profile/cubit/bengkel_profile_cubit.dart';
import 'package:service_go/modules/service/presentation/screens/customer_form/customer_servis_form_screen.dart';
import 'package:sizer/sizer.dart';

part 'widget/profile_pic.dart';
part 'widget/user_data.dart';
part 'widget/profile.dart';
part 'widget/actions.dart';
part 'widget/section_wrapper.dart';
part 'widget/jadwal_bengkel.dart';

@RoutePage()
class BengkelProfileScreen extends StatelessWidget {
  final String userId;
  const BengkelProfileScreen(
      {super.key, @PathParam("id") required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BengkelProfileScreenCubit>()..getBengkelProfile(userId),
      child: Scaffold(
        appBar: SGAppBar(
          pageTitle: "Profil Bengkel",
          actions: [
            if (userId == context.userSession.userId)
              SGAppBarItemAction.icon(
                  icon: Icons.logout,
                  onTap: () {
                    context.logout();
                  }),
          ],
        ),
        body: BlocBuilder<BengkelProfileScreenCubit, BengkelProfileScreenState>(
          builder: (context, state) => switch (state) {
            BengkelProfileScreenSuccess() => _Content(
                profile: state.bengkelProfile,
              ),
            BengkelProfileScreenError() => SGError(
                message: state.message,
                retry: state.refresh,
              ),
            BengkelProfileScreenLoading() => const SGLoadingOverlay()
          },
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final BengkelProfile profile;
  const _Content({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final isBengkel = context.userSession.isBengkel;
    return Stack(
      children: [
        SizedBox.expand(
          child: RefreshIndicator(
            onRefresh: () async => context.read<BengkelProfileScreenCubit>()
              ..getBengkelProfile(profile.id),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      profile.nama,
                      style: context.text.labelLarge?.copyWith(fontSize: 20.sp),
                    ),
                    _ProfilePic(profile.profile),
                    14.verticalSpace,
                    _BengkelActions(bengkel: profile),
                    24.verticalSpace,
                    _UserData(userData: context.userSession.userData),
                    24.verticalSpace,
                    _Profile(
                      profile: profile,
                    ),
                    24.verticalSpace,
                    _JadwalBengkel(
                      profile: profile,
                      jadwalBengkel: profile.jadwalBengkel,
                    ),
                    if (!isBengkel)
                      SGHideWidget(child: _ButtonPesan(bengkelId: profile.id))
                  ],
                ),
              ),
            ),
          ),
        ),
        if (!isBengkel)
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ButtonPesan(bengkelId: profile.id),
            ],
          )
      ],
    );
  }
}

class _ButtonPesan extends StatelessWidget {
  final String bengkelId;
  const _ButtonPesan({required this.bengkelId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.color.surface,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: .5,
            offset: Offset(0.0, 0), //(x,y)
            blurRadius: .2,
          ),
        ],
      ),
      child: SGElevatedButton(
          label: "Pesan",
          onPressed: () {
            context.router.push(CustomerServisFormRoute(
                mode: CustomerServisFormCreate.byId(bengkelId: bengkelId)));
          }),
    );
  }
}
