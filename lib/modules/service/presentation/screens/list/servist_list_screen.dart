import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_go/infrastructure/ext/ctx_ext.dart';
import 'package:service_go/infrastructure/ext/double_ext.dart';
import 'package:service_go/infrastructure/routing/router.gr.dart';
import 'package:service_go/infrastructure/service_locator/service_locator.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/widgets/filter/filter.dart';
import 'package:service_go/infrastructure/widgets/layouts/appbar/appbar.dart';
import 'package:service_go/modules/service/domain/model/servis.dart';
import 'package:service_go/modules/service/presentation/screens/list/cubit/servis_list_filter_cubit.dart';
import 'package:service_go/modules/service/presentation/screens/list/cubit/servis_list_queries.dart';
import 'package:service_go/modules/service/presentation/widgets/list/servis_list_widget.dart';
import 'package:sizer/sizer.dart';

class ServisListType {
  final bool isBengkel;
  final String userId;

  ServisListType(this.isBengkel, this.userId);

  SGQueryField get queryField =>
      SGQueryField(isBengkel ? "bengkelId" : "customerId", isEqual: userId);
}

@RoutePage()
class ServisListScreen extends StatelessWidget {
  final SGDataQuery? initialQuery;
  final ServisListType? type;
  final void Function(Servis servis, void Function() refresh)? onServisClick;
  const ServisListScreen(
      {super.key, this.initialQuery, this.onServisClick, this.type});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ServisListFilterCubit>(param1: initialQuery, param2: type)
            ..applyQuery([]),
      child: BlocProvider(
        create: (context) => SGFilterCubit(SGFilterState(
          filterGroups: context.read<ServisListFilterCubit>().filters,
        )),
        child: _Content(type: type, onServisClick: onServisClick),
      ),
    );
  }
}

class _Content extends StatefulWidget {
  const _Content({
    required this.type,
    required this.onServisClick,
  });

  final ServisListType? type;
  final void Function(Servis servis, void Function() refresh)? onServisClick;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> with TickerProviderStateMixin {
  late final TabController _tabController;
  final _tabs = [null, ...ServisListQueries.status.filters];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () {
      final cubit = context.read<SGFilterCubit>();
      final currentTab = _tabs[_tabController.index];
      final currentFilters = [...cubit.state.filterGroups];
      final currentStatus = currentFilters.removeAt(0);
      if (currentTab != null) {
        currentStatus.clear();
        currentStatus.selectItem(currentTab);
      } else {
        final filerLength = currentStatus.selected.length;
        if (filerLength == 1) {
          currentStatus.clear();
        }
      }
      cubit.setNewFilterGroup([currentStatus, ...currentFilters]);
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChange);
    super.dispose();
  }

  void _onFilterChange(List<FilterGroup> filterGroup) {
    final cubit = context.read<ServisListFilterCubit>();
    final statusFilter = cubit.filters[0];
    final selected = statusFilter.selected;
    if (selected.isNotEmpty) {
      if (selected.length == 1) {
        _tabController.index =
            _tabs.indexWhere((element) => element == selected.first);
      } else {
        _tabController.index = 0;
      }
    }
    cubit.applyQuery(filterGroup);
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return Scaffold(
      appBar: SGAppBar(
        pageTitle: "Servis",
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: color.onSurfaceVariant,
          labelColor: color.primary,
          indicatorColor: color.primary,
          isScrollable: true,
          controller: _tabController,
          tabs:
              _tabs.map((e) => Tab(text: e != null ? e.text : "All")).toList(),
        ),
        actions: [
          if (widget.type?.isBengkel == false)
            SGAppBarItemAction.icon(
                icon: Icons.add,
                onTap: () {
                  context.router.push(const BengkelListRoute());
                })
        ],
      ),
      body: BlocBuilder<ServisListFilterCubit, SGDataQuery>(
        builder: (context, state) {
          return Column(
            children: [
              2.h.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                child: SGFilter(
                  cubit: context.read<SGFilterCubit>(),
                  onFilterChange: _onFilterChange,
                ),
              ),
              2.h.verticalSpace,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _onFilterChange(
                        context.read<SGFilterCubit>().state.filterGroups);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      child: ServisListAutoWidget(
                        onTap: widget.onServisClick,
                        query: state,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
