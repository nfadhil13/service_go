import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/widgets/filter/filter.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/presentation/screens/list/servist_list_screen.dart';

@injectable
class ServisListFilterCubit extends Cubit<SGDataQuery> {
  final List<FilterGroup> filters;
  final ServisListType? type;
  ServisListFilterCubit(
      @factoryParam SGDataQuery? initialQuery, @factoryParam this.type)
      : filters = [
          FilterGroupMultiple(
              title: "Status Servis",
              filters: ServisStatus.values
                  .map((e) => FilterData(
                      text: e.statusName,
                      queryField: SGQueryField("status", whereIn: [e.id])))
                  .toList()),
          FilterGroupSingle(title: "Waktu Servis", filters: [
            FilterData(
                text: "Hari ini",
                queryField:
                    SGQueryField("tanggalService", isGreaterThanOrEqualTo: () {
                  DateTime now = DateTime.now();
                  DateTime date = DateTime(now.year, now.month, now.day);
                  return Timestamp.fromDate(date);
                }(), isLessThanOrEqualTo: () {
                  DateTime now = DateTime.now();
                  DateTime date = DateTime(now.year, now.month, now.day);
                  return Timestamp.fromDate(date.add(const Duration(days: 1)));
                }())),
            FilterData(
                text: "Besok",
                queryField:
                    SGQueryField("tanggalService", isGreaterThanOrEqualTo: () {
                  DateTime now = DateTime.now();
                  DateTime date = DateTime(now.year, now.month, now.day);

                  return Timestamp.fromDate(date.add(const Duration(days: 1)));
                }(), isLessThanOrEqualTo: () {
                  DateTime now = DateTime.now();
                  DateTime date = DateTime(now.year, now.month, now.day);
                  return Timestamp.fromDate(date.add(const Duration(days: 2)));
                }())),
            FilterData(
                text: "Minggu Ini",
                queryField:
                    SGQueryField("tanggalService", isGreaterThanOrEqualTo: () {
                  DateTime now = DateTime.now();
                  DateTime date = DateTime(now.year, now.month, now.day);
                  return Timestamp.fromDate(date);
                }(), isLessThanOrEqualTo: () {
                  DateTime now = DateTime.now();
                  DateTime date = DateTime(now.year, now.month, now.day);
                  return Timestamp.fromDate(date.add(const Duration(days: 7)));
                }()))
          ])
        ],
        super(initialQuery ?? const SGDataQuery());

  void applyQuery(List<FilterGroup> groups) {
    final query = [for (final filter in groups) ...filter.mergeQueryFields()];
    final type = this.type;
    if (type != null) query.add(type.queryField);
    print(query);
    emit(state.copyWith(query: query));
  }
}
