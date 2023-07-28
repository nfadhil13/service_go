part of 'filter.dart';

class _FilterItem extends StatelessWidget {
  final bool isSelected;
  final FilterData filterData;
  const _FilterItem(
      {super.key, required this.isSelected, required this.filterData});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final primary = color.primary;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: isSelected ? primary.withOpacity(.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected ? primary : color.outlineVariant, width: .7)),
      child: Text(filterData.text,
          style: context.text.labelMedium
              ?.copyWith(color: isSelected ? primary : color.outline)),
    );
  }
}
