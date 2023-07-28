import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/ext/list_ext.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/widgets/buttons/elevated_button.dart';
import 'package:service_go/infrastructure/widgets/hide_widget.dart';
import 'package:service_go/infrastructure/widgets/layouts/bottomsheet/bottom_sheet_container.dart';
import 'package:sizer/sizer.dart';

part 'filter_button.dart';
part 'filter_data.dart';
part 'filter_item.dart';
part 'selected_filters.dart';
part 'filter_group.dart';

class SGFilter extends StatefulWidget {
  final List<FilterGroup> filterGroups;
  final void Function(List<FilterGroup> filterGroups)? onChange;
  const SGFilter({super.key, required this.filterGroups, this.onChange});

  @override
  State<SGFilter> createState() => _SGFilterState();
}

class _SGFilterState extends State<SGFilter> {
  List<FilterGroup> _filterGroups = [];
  Set<_SelectedFilterData> _selectedFilters = {};
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _filterGroups = widget.filterGroups;
    _calculate();
  }

  void _calculate() {
    _count = _selectedFilters.length;
  }

  void _onItemClicked(_SelectedFilterData selectedList) {
    _selectedFilters.remove(selectedList);
    _filterGroups[selectedList.groupdIndex]
        ._onItemSelected(selectedList.filter);
    _calculate();
    widget.onChange?.call(_filterGroups);
    setState(() {});
  }

  void _showBottomSheet() async {
    final result = await SGFilterBottomSheet.show(context, _filterGroups);
    if (result == null) return;
    _selectedFilters = {
      for (var i = 0; i < result.length; i++)
        ...(result[i].selected).map((e) => _SelectedFilterData(i, e))
    };
    _filterGroups = result;
    widget.onChange?.call(_filterGroups);
    _calculate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _SelectedFilters(
        filters: _selectedFilters,
        onItemClicked: _onItemClicked,
        count: _count,
        onShowFilterBottomSheet: _showBottomSheet);
  }
}

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

class _SelectedFilterData {
  final int groupdIndex;
  final FilterData filter;

  _SelectedFilterData(this.groupdIndex, this.filter);
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
      element._reset();
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
                                        e._onItemSelected(filterData);
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
