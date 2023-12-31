import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/modules/bengkel/data/datasource/remote/bengkel_profile_remote_dts.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';

@Injectable(as: BengkelProfileRepository)
class BengkelProfileRepositoryImpl implements BengkelProfileRepository {
  final BengkelProfileRemoteDTS _remoteDTS;

  BengkelProfileRepositoryImpl(this._remoteDTS);

  @override
  Future<BengkelProfile?> getBengkelProfile(String userId) =>
      _remoteDTS.fetchByUser(userId);

  @override
  Future<BengkelProfile> createOrUpdateProfile(BengkelProfile bengkelProfile) =>
      _remoteDTS.put(bengkelProfile);

  @override
  Future<List<BengkelProfileWithDistance>> getBengkelList(
          {SGDataQuery? queryData}) =>
      _remoteDTS.getBengkelList(dataQuery: queryData);

  @override
  Future<int> count({SGDataQuery? queryData}) =>
      _remoteDTS.count(dataQuery: queryData);
}
