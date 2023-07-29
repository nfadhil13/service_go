import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
part 'bottom_sheet.dart';

part 'cubit/sg_filter_cubit.dart';
part 'cubit/sg_filter_state.dart';

class SGFilter extends StatelessWidget {
  final SGFilterCubit? cubit;
  final List<FilterGroup> groupList;
  final void Function(List<FilterGroup> groupList)? onFilterChange;

  const SGFilter(
      {super.key, this.cubit, this.onFilterChange, this.groupList = const []});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        if (cubit == null)
          BlocProvider(
            create: (context) =>
                SGFilterCubit(SGFilterState(filterGroups: groupList)),
          ),
        if (cubit != null)
          BlocProvider.value(
            value: cubit!,
          ),
      ],
      child: BlocListener<SGFilterCubit, SGFilterState>(
        listener: (context, state) {
          onFilterChange?.call(state.filterGroups);
        },
        child: _Content(
          groupList: groupList,
          isInnerCubit: cubit == null,
        ),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  final bool isInnerCubit;

  final List<FilterGroup> groupList;
  const _Content({
    super.key,
    required this.isInnerCubit,
    required this.groupList,
  });

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  void didUpdateWidget(covariant _Content oldWidget) {
    if (widget.isInnerCubit && oldWidget.groupList != widget.groupList) {
      context.read<SGFilterCubit>().setNewFilterGroup(widget.groupList);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _showBottomSheet(BuildContext context) async {
    final cubit = context.read<SGFilterCubit>();
    final result =
        await SGFilterBottomSheet.show(context, cubit.state.filterGroups);
    if (result == null) return;
    cubit.setNewFilterGroup(result);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SGFilterCubit, SGFilterState>(
      builder: (context, state) {
        return _SelectedFilters(
            filters: state.selectedFilters,
            onItemClicked: context.read<SGFilterCubit>().removeSelectedItem,
            count: state.count,
            onShowFilterBottomSheet: () => _showBottomSheet(context));
      },
    );
  }
}
