import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/modules/profile/presentation/screens/bengkel_profile_form/bengkel_profile_form_screen.dart';
import 'package:service_go/modules/service/presentation/screens/list/servist_list_screen.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

@RoutePage()
class BengkelHomeScreen extends StatefulWidget {
  const BengkelHomeScreen({super.key});

  @override
  State<BengkelHomeScreen> createState() => _BengkelHomeScreenState();
}

class _HomeItem {
  final IconData icon;
  final String text;
  final Widget Function(BuildContext context) builder;
  const _HomeItem(this.icon, this.builder, this.text);
}

class _BengkelHomeScreenState extends State<BengkelHomeScreen> {
  final _items = [
    _HomeItem(
        Icons.checklist,
        (context) => ServisListScreen(
              onServisClick: (servis) {
                final id = servis.id.id;
                if (id == null) return;
                context.router.push(ServisBengkelDetailRoute(servisId: id));
              },
              type: ServisListType(true, context.userSession.userId),
            ),
        "Pesanan"),
    _HomeItem(
        Icons.person, (context) => const BengkelProfileFormScreen(), "Profile"),
  ];

  int _activeIndex = 0;

  void _scanBarcode() async {
    final router = context.router;
    var res = await router.pushNativeRoute(MaterialPageRoute(
      builder: (context) => const SimpleBarcodeScannerPage(),
    ));
    if (res is! String) return;
    router.push(ServisBengkelDetailRoute(servisId: res));
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return Scaffold(
      body: _items[_activeIndex].builder(context),
      floatingActionButton: FloatingActionButton(
          backgroundColor: color.primary,
          onPressed: _scanBarcode,
          child: const Icon(Icons.qr_code_scanner)),
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
