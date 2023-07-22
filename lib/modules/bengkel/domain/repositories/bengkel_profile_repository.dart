import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';

abstract class BengkelProfileRepository {
  Future<BengkelProfile?> getBengkelProfile(String userId);
  Future<BengkelProfile> createOrUpdateProfile(BengkelProfile bengkelProfile);
  Future<List<BengkelProfileWithDistance>> getBengkelList(
      {SGDataQuery? queryData});
}
