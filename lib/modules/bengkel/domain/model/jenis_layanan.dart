import 'package:equatable/equatable.dart';

class JenisLayanan extends Equatable {
  final String id;
  final String name;

  const JenisLayanan({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
