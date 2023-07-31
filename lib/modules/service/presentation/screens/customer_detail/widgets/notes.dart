part of '../servis_customer_detail_screen.dart';

class _Notes extends StatelessWidget {
  final String note;
  const _Notes({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Catatan",
          style: context.text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          note.isEmpty ? "-" : note,
          style: context.text.bodyMedium
              ?.copyWith(color: context.color.onBackground),
        )
      ],
    );
  }
}
