import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/types/gis/distance.dart';
import 'package:service_go/infrastructure/types/image.dart';
import 'package:service_go/infrastructure/types/query.dart';
import 'package:service_go/infrastructure/utils/storage/sg_storage_helper.dart';
import 'package:service_go/modules/bengkel/data/datasource/firestore/jenis_layanan_firestore_dts.dart';
import 'package:service_go/modules/bengkel/data/mapper/remote/bengkel_profile/bengkel_profile_dto.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';

import '../firestore/bengkel_firestore_dts.dart';

abstract class BengkelProfileRemoteDTS {
  Future<BengkelProfile?> fetchByUser(String userId);
  Future<BengkelProfile> put(BengkelProfile bengkelProfile);
  Future<List<BengkelProfileWithDistance>> getBengkelList(
      {SGDataQuery? dataQuery});
}

@Injectable(as: BengkelProfileRemoteDTS)
class BengkelProfileRemoteDTSImpl implements BengkelProfileRemoteDTS {
  final BengkelProfileFirestoreDTS _profileFirestore;
  final JenisLayananFirestoreDTS _jenisLayananFirestoreDTS;
  final SGStorageHelper _storage;
  BengkelProfileRemoteDTSImpl(
      this._profileFirestore, this._jenisLayananFirestoreDTS, this._storage)
      : super();

  @override
  Future<BengkelProfile?> fetchByUser(String userId) async {
    final bengkelProfile = await _profileFirestore.fetchOne(userId);
    if (bengkelProfile == null) return null;
    final jenisLayananList =
        await _jenisLayananFirestoreDTS.fetchByIds(bengkelProfile.layananIds);
    return bengkelProfile.toDomain(jenisLayananList);
  }

  @override
  Future<BengkelProfile> put(BengkelProfile bengkelProfile) async {
    final image = bengkelProfile.profile;

    final imageUrl = switch (image) {
      SGFileImage() => await _storage.uploadImage(image),
      SGNetworkImage() => image.data
    };
    await _profileFirestore.put(
        BengkelProfileDTO.fromDomain(bengkelProfile, imageUrl),
        bengkelProfile.id);
    return bengkelProfile;
  }

  @override
  Future<List<BengkelProfileWithDistance>> getBengkelList(
      {SGDataQuery? dataQuery}) async {
    final bengkelList =
        await _profileFirestore.fetchAllWithDistance(query: dataQuery);
    if (bengkelList.isEmpty) return [];
    return Future.wait(bengkelList.map((bengkelWithDistance) async {
      final bengkel = bengkelWithDistance.data;
      final jenisLayanan =
          await _jenisLayananFirestoreDTS.fetchByIds(bengkel.layananIds);
      return SGDistance(
          data: bengkel.toDomain(jenisLayanan),
          distanceInKm: bengkelWithDistance.distanceInKm);
    }));
  }
}
