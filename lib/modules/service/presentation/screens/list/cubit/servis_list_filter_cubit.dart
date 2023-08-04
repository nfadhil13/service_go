import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/utils/firestore/firestore_field.dart';
import 'package:service_go/infrastructure/widgets/filter/filter.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';
import 'package:service_go/modules/service/presentation/screens/list/cubit/servis_list_queries.dart';
import 'package:service_go/modules/service/presentation/screens/list/servist_list_screen.dart';

@injectable
class ServisListFilterCubit extends Cubit<SGDataQuery> {
  final List<FilterGroup> filters;
  final ServisListType? type;
  ServisListFilterCubit(
      @factoryParam SGDataQuery? initialQuery, @factoryParam this.type)
      : filters = [ServisListQueries.status, ServisListQueries.time],
        super(initialQuery ?? const SGDataQuery());

  void applyQuery(List<FilterGroup> groups) {
    final query = [for (final filter in groups) ...filter.mergeQueryFields()];
    final type = this.type;
    if (type != null) query.add(type.queryField);

    emit(state.copyWith(query: query, sort: [
      SGSort(key: "tanggalService", type: SGSortType.asc),
      SGSort(key: "status", type: SGSortType.desc),
      SGSort(key: FireStoreField.updatedAtKey, type: SGSortType.desc)
    ]));
  }
}
