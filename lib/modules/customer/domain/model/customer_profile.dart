import 'package:equatable/equatable.dart';

class CustomerProfile extends Equatable {
  final String id;
  final String nama;
  final String phoneNumber;

  const CustomerProfile(
      {required this.nama, required this.phoneNumber, required this.id});

  @override
  List<Object?> get props => [id, nama, phoneNumber];
}
