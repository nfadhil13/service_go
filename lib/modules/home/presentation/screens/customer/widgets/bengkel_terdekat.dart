part of '../customer_home_screen.dart';

class _BengkelTerdekatSection extends StatelessWidget {
  const _BengkelTerdekatSection({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    final location = context.currentLocation;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bengkel Terdekat",
              style: text.labelLarge
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.5.sp),
            ),
            InkWell(
              onTap: () => context.router.push(const BengkelListRoute()),
              child: Text(
                "Lihat Lebih",
                style: text.bodyMedium?.copyWith(color: color.primary),
              ),
            )
          ],
        ),
        3.h.verticalSpace,
        BengkelListWidget(
          onTap: (profile, index) {
            context.router.push(BengkelProfileRoute(userId: profile.id));
          },
          query: SGDataQuery(
              limit: 2,
              query: const [SGQueryField("isOpen", isEqual: true)],
              locationQuery: SGLocationQuery(
                  field: "lokasi", radius: 20, center: location.latLgn)),
        )
      ],
    );
  }
}
