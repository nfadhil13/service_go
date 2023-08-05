part of '../customer_profile_screen.dart';

class _Section extends StatelessWidget {
  final String title;
  final List<
      (
        String title,
        String item,
      )> items;
  const _Section({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final text = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(title,
              style: text.titleMedium?.copyWith(
                color: color.onSurface,
                fontWeight: FontWeight.w600,
              )),
        ),
        4.verticalSpace,
        Divider(
          height: 2,
          color: color.outline,
        ),
        5.verticalSpace,
        ...items.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.$1,
                    style: text.titleSmall,
                  ),
                  2.verticalSpace,
                  Text(
                    e.$2,
                    style: text.bodyMedium?.copyWith(color: color.outline),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
