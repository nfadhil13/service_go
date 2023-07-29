part of '../filter.dart';

class SGFilterState extends Equatable {
  final List<FilterGroup> filterGroups;
  final Set<SGSelectedFilterData> selectedFilters;

  const SGFilterState({
    this.filterGroups = const [],
    this.selectedFilters = const {},
  });

  int get count => selectedFilters.length;

  @override
  List<Object> get props => [filterGroups, selectedFilters, count];
}
