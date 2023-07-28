part of 'filter.dart';

class _FilterGroup extends StatelessWidget {
  final FilterGroup filterGroup;
  final void Function(FilterData filterData)? onItemClicked;
  const _FilterGroup(
      {super.key, required this.filterGroup, this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.color;
    final textTheme = context.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filterGroup.title,
          style: textTheme.labelMedium?.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: colorTheme.onSurface),
        ),
        const SizedBox(height: 8),
        Wrap(
          runSpacing: 12,
          spacing: 8,
          children: filterGroup.filters
              .map((e) => InkWell(
                    onTap: () => onItemClicked?.call(e),
                    child: _FilterItem(
                      filterData: e,
                      isSelected: filterGroup._isItemSelected(e),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}
