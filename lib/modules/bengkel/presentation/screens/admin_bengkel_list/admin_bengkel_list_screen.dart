import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/modules/bengkel/presentation/widgets/bengkel_list/bengkel_list_widget.dart';

@RoutePage()
class AdminBengkelListScreen extends StatelessWidget {
  const AdminBengkelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SGAppBar(
        pageTitle: "Bengkel",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: BengkelListWidget(
          onTap: (bengkel, _) {
            context.router.push(BengkelProfileRoute(userId: bengkel.id));
          },
        ),
      ),
    );
  }
}
