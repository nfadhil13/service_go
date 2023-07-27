part of '../customer_home_screen.dart';

class _ServisBerjalan extends StatelessWidget {
  const _ServisBerjalan({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final color = context.color;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Servis Berjalan",
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
        1.5.h.verticalSpace,
        ServisListAutoWidget(
          query: SGDataQuery(limit: 2, query: [
            SGQueryField("status", whereNotIn: [
              ServisStatus.ditolak.id,
              ServisStatus.serviceSelesai.id
            ]),
          ]),
        )
      ],
    );
  }
}
