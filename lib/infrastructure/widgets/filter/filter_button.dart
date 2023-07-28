part of 'filter.dart';

class _FilterButton extends StatelessWidget {
  final int count;
  final VoidCallback onTap;
  const _FilterButton({super.key, required this.count, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final isEmpty = count == 0;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.outlineVariant, width: .7)),
        child: Row(
          children: [
            if (isEmpty)
              const Icon(
                Icons.filter_list_alt,
                size: 16,
              ),
            if (!isEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  count.toString(),
                  style:
                      context.text.labelSmall?.copyWith(color: color.onPrimary),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(isEmpty ? "Filter" : "Selected",
                  style:
                      context.text.labelMedium?.copyWith(color: color.outline)),
            ),
          ],
        ),
      ),
    );
  }
}
