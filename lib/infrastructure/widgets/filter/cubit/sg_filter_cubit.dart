part of '../filter.dart';

class SGFilterCubit extends Cubit<SGFilterState> {
  SGFilterCubit(super.initialState);

  void removeSelectedItem(SGSelectedFilterData selectedItem) {
    final state = this.state;
    final selectedFilters = {...state.selectedFilters};
    final groups = [...state.filterGroups];
    selectedFilters.remove(selectedItem);
    groups[selectedItem.groupdIndex].selectItem(selectedItem.filter);

    emit(SGFilterState(filterGroups: groups, selectedFilters: selectedFilters));
  }

  void setNewFilterGroup(List<FilterGroup> filterGroups) {
    final selectedFilters = {
      for (var i = 0; i < filterGroups.length; i++)
        ...(filterGroups[i].selected).map((e) => SGSelectedFilterData(i, e))
    };
    emit(SGFilterState(
        filterGroups: filterGroups, selectedFilters: selectedFilters));
  }
}
