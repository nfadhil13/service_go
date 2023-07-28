part of 'filter.dart';

class FilterData extends Equatable {
  final String text;
  final SGQueryField queryField;

  const FilterData({required this.text, required this.queryField});

  @override
  List<Object?> get props => [text, queryField];
}

sealed class FilterGroup<T> extends Equatable {
  final String title;
  final Set<FilterData> filters;

  FilterGroup({required this.title, required List<FilterData> filters})
      : filters = filters.toSet();

  bool _isItemSelected(FilterData filterData);

  void _onItemSelected(FilterData filterData);

  void _reset();

  Set<FilterData> get selected;

  List<SGQueryField> mergeQueryFields();

  int get _count;

  @override
  List<Object?> get props => [filters, title];
}

// ignore: must_be_immutable
class FilterGroupSingle extends FilterGroup {
  FilterData? selectedQuery;

  FilterGroupSingle(
      {required super.title, required super.filters, int? initialSelectedIndex})
      : selectedQuery =
            initialSelectedIndex != null ? filters[initialSelectedIndex] : null;

  @override
  bool _isItemSelected(FilterData filterData) => filterData == selectedQuery;

  @override
  List<SGQueryField> mergeQueryFields() =>
      [if (selectedQuery != null) selectedQuery!.queryField];

  @override
  void _onItemSelected(FilterData filterData) => selectedQuery = filterData;

  @override
  int get _count => selectedQuery != null ? 1 : 0;

  @override
  void _reset() => selectedQuery = null;

  @override
  Set<FilterData> get selected => {if (selectedQuery != null) selectedQuery!};
}

class FilterGroupMultiple extends FilterGroup {
  final Set<FilterData> selectedList;

  FilterGroupMultiple(
      {required super.title,
      required super.filters,
      List<int> initialSelectedIndexes = const []})
      : selectedList = initialSelectedIndexes.map((e) => filters[e]).toSet();

  @override
  bool _isItemSelected(FilterData filterData) =>
      selectedList.contains(filterData);

  Iterable<Object?>? mergeList(
          Iterable<Object?>? first, Iterable<Object?>? second) =>
      first == null && second == null
          ? null
          : [if (first != null) ...first, if (second != null) ...second];

  @override
  List<SGQueryField> mergeQueryFields() {
    SGQueryField? field;
    if (selectedList.isNotEmpty) {
      field = selectedList.first.queryField;
      for (var element in selectedList) {
        final query = element.queryField;
        field = field?.copyWith(
            arrayContains: query.arrayContains,
            arrayContainsAny:
                mergeList(field.arrayContainsAny, query.arrayContainsAny),
            isEqual: query.isEqual,
            isGreaterThan: query.isGreaterThan,
            isGreaterThanOrEqualTo: query.isGreaterThanOrEqualTo,
            isLessThan: query.isLessThan,
            isLessThanOrEqualTo: query.isLessThanOrEqualTo,
            isNotEqual: query.isNotEqual,
            isNull: query.isNull,
            whereIn: mergeList(query.whereIn, field.whereIn),
            whereNotIn: mergeList(query.whereNotIn, field.whereNotIn));
      }
    }
    return [if (field != null) field];
  }

  @override
  void _onItemSelected(FilterData filterData) {
    final contains = selectedList.contains(filterData);
    if (contains) {
      selectedList.remove(filterData);
    } else {
      selectedList.add(filterData);
    }
  }

  @override
  int get _count => selectedList.length;

  @override
  void _reset() => selectedList.clear();

  @override
  Set<FilterData> get selected => selectedList;
}
