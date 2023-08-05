import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/architecutre/cubits/location/location_cubit.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/icons/text.dart';
import 'package:service_go/infrastructure/widgets/map/map_picker.dart';
import 'package:service_go/modules/bengkel/presentation/widgets/bengkel_list/bengkel_list_widget.dart';
import 'package:service_go/modules/customer/presentation/cubits/cubit/customer_profile_cubit.dart';
import 'package:service_go/modules/profile/presentation/screens/customer_profile/customer_profile_screen.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/presentation/screens/list/servist_list_screen.dart';
import 'package:service_go/modules/service/presentation/widgets/list/servis_list_widget.dart';
import 'package:sizer/sizer.dart';

part 'widgets/app_bar.dart';
part 'widgets/bengkel_terdekat.dart';
part 'widgets/current_location.dart';
part 'widgets/servis_berjalan.dart';

@RoutePage()
class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _HomeItem {
  final IconData icon;
  final String text;
  final Widget Function(BuildContext context) builder;
  const _HomeItem(this.icon, this.builder, this.text);
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final _items = [
    _HomeItem(Icons.home, (context) => const _Home(), "Pesanan"),
    _HomeItem(
        Icons.person,
        (context) => CustomerProfileScreen(
              userId: context.userSession.userId,
            ),
        "Profile"),
  ];

  void _buatPesanan() {
    context.router.push(const BengkelListRoute());
  }

  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return Scaffold(
      body: _items[_activeIndex].builder(context),
      floatingActionButton: FloatingActionButton(
          backgroundColor: color.primary,
          onPressed: _buatPesanan,
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _items.length,
        gapLocation: GapLocation.center,
        height: 64,
        notchSmoothness: NotchSmoothness.smoothEdge,
        tabBuilder: (index, isActive) {
          final data = _items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(data.icon,
                  size: 24, color: isActive ? color.primary : color.outline),
              Text(
                data.text,
                style: text.labelSmall?.copyWith(
                    fontSize: 10,
                    color: isActive ? color.primary : color.outline),
              )
            ],
          );
        },
        activeIndex: _activeIndex,
        onTap: (index) => setState(() => _activeIndex = index),
      ),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _HomeAppBar(),
          2.h.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: const _CurrentLocation(),
          ),
          2.5.h.verticalSpace,
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
    );
  }
}
