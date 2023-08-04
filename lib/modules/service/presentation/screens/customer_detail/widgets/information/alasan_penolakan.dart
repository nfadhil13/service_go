part of '../../servis_customer_detail_screen.dart';

class _AlasanPenolakan extends StatelessWidget {
  final String alasanPenolakan;
  const _AlasanPenolakan({super.key, required this.alasanPenolakan});

  @override
  Widget build(BuildContext context) {
    return SGExpandableContainer(
        color: context.color.error,
        title: "Alasan Penolakan",
        child: Text(
          alasanPenolakan,
          style:
              context.text.bodySmall?.copyWith(color: context.color.onSurface),
        ));
  }
}
