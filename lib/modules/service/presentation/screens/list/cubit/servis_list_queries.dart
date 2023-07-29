import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/widgets/filter/filter.dart';
import 'package:service_go/modules/service/domain/model/servis_status.dart';

class ServisListQueries {
  static FilterGroupMultiple get status => FilterGroupMultiple(
      title: "Status Servis",
      filters: ServisStatus.values
          .map((e) => FilterData(
              text: e.statusName,
              queryField: SGQueryField("status", whereIn: [e.id])))
          .toList());

  static FilterGroupSingle get time {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return FilterGroupSingle(title: "Waktu Servis", filters: [
      FilterData(
          text: "Hari ini",
          queryField: SGQueryField("tanggalService",
              isGreaterThanOrEqualTo: Timestamp.fromDate(today),
              isLessThanOrEqualTo:
                  Timestamp.fromDate(today.add(const Duration(days: 1))))),
      FilterData(
          text: "Besok",
          queryField: SGQueryField("tanggalService",
              isGreaterThanOrEqualTo:
                  Timestamp.fromDate(today.add(const Duration(days: 1))),
              isLessThanOrEqualTo:
                  Timestamp.fromDate(today.add(const Duration(days: 2))))),
      FilterData(
          text: "Minggu Ini",
          queryField: SGQueryField("tanggalService",
              isGreaterThanOrEqualTo: Timestamp.fromDate(today),
              isLessThanOrEqualTo:
                  Timestamp.fromDate(today.add(const Duration(days: 7)))))
    ]);
  }
}
