import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/widgets/icons/text.dart';
import 'package:sizer/sizer.dart';

part 'widgets/app_bar.dart';
part 'widgets/bengkel_terdekat.dart';

@RoutePage()
class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [_HomeAppBar()],
        ),
      ),
    );
  }
}
