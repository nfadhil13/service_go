part of 'filter.dart';

class _SelectedFilters extends StatelessWidget {
  final Set<_SelectedFilterData> filters;
  final int count;
  final VoidCallback onShowFilterBottomSheet;
  final void Function(_SelectedFilterData data)? onItemClicked;
  const _SelectedFilters(
      {super.key,
      required this.filters,
      this.onItemClicked,
      required this.count,
      required this.onShowFilterBottomSheet});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _FilterButton(count: count, onTap: onShowFilterBottomSheet),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: filters
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: InkWell(
                          onTap: () => onItemClicked?.call(e),
                          child: _FilterItem(
                            filterData: e.filter,
                            isSelected: true,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
