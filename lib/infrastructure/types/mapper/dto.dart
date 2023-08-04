abstract class DTO<Domain, Params> {
  Domain toDomain(Params params);
}

abstract class DTONoParams<Domain> {
  Domain toDomain();
}

class BaseModel {}
