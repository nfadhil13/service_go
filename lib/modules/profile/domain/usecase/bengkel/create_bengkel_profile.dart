import 'package:injectable/injectable.dart';
import 'package:service_go/infrastructure/architecutre/use_case.dart';
import 'package:service_go/infrastructure/types/resource.dart';
import 'package:service_go/modules/bengkel/domain/model/bengkel_profile.dart';
import 'package:service_go/modules/bengkel/domain/repositories/bengkel_profile_repository.dart';

@injectable
class CreateBengkelProfile extends Usecase<BengkelProfile, BengkelProfile> {
  final BengkelProfileRepository _repository;

  CreateBengkelProfile(this._repository);

  @override
  Future<Resource<BengkelProfile>> execute(BengkelProfile params) =>
      _repository.createOrUpdateProfile(params).asResource;
}
