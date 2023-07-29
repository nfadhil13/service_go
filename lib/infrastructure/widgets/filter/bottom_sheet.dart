part of 'filter.dart';

class SGFilterBottomSheet extends StatefulWidget {
  final List<FilterGroup> filterGroups;
  const SGFilterBottomSheet({super.key, required this.filterGroups});

  static Future<List<FilterGroup>?> show(
      BuildContext context, List<FilterGroup> filterGroups) async {
    final result = await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => SGFilterBottomSheet(filterGroups: filterGroups));
    if (result is List<FilterGroup>) return result;
    return null;
  }

  @override
  State<SGFilterBottomSheet> createState() => _SGFilterBottomSheetState();
}

class _SGFilterBottomSheetState extends State<SGFilterBottomSheet> {
  List<FilterGroup> _filterGroups = [];
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _filterGroups = widget.filterGroups;
    _calculate();
  }

  void _calculate() {
    _count = _filterGroups
        .map((e) => e._count)
        .reduce((value, element) => value + element);
  }

  void _reset() {
    for (var element in _filterGroups) {
      element.clear();
    }
    _calculate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = context.color;
    return Stack(
      children: [
        DraggableScrollableSheet(
            maxChildSize: .9,
            minChildSize: .5,
            initialChildSize: .5,
            builder: (context, controller) {
              return SGBottomSheetContainer(
                child: SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      2.h.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5.h),
                        child: _BottomSheetFilterTitle(
                            count: _count, onReset: _reset),
                      ),
                      4.verticalSpace,
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: colorTheme.outlineVariant,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: widget.filterGroups
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(top: 24),
                                    child: _FilterGroup(
                                      filterGroup: e,
                                      onItemClicked: (FilterData filterData) {
                                        e.selectItem(filterData);
                                        _calculate();
                                        setState(() {});
                                      },
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const SGHideWidget(child: _BottomSheetButton())
                    ],
                  ),
                ),
              );
            }),
        Positioned(
            bottom: 0,
            child: _BottomSheetButton(
              onSave: () {
                context.router.pop(_filterGroups);
              },
              filterCount: _count,
            ))
      ],
    );
  }
}

class _BottomSheetFilterTitle extends StatelessWidget {
  final int count;
  final VoidCallback onReset;
  const _BottomSheetFilterTitle({
    super.key,
    required this.count,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Filters",
          style: context.text.labelLarge
              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        Builder(
          builder: (context) {
            if (count == 0) {
              return const SizedBox();
            }
            return InkWell(
              onTap: onReset,
              child: Text(
                "Reset",
                style: context.text.labelLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: context.color.primary),
              ),
            );
          },
        )
      ],
    );
  }
}

class _BottomSheetButton extends StatelessWidget {
  const _BottomSheetButton({super.key, this.onSave, this.filterCount = 0});
  final VoidCallback? onSave;
  final int filterCount;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, -7),
          ),
        ], color: context.color.surface),
        width: 100.w,
        child: SGElevatedButton(
          fillParent: true,
          label: "Apply${filterCount == 0 ? "" : "($filterCount)"}",
          onPressed: onSave,
        ));
  }
}
