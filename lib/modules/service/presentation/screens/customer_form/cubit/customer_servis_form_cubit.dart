import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customer_servis_form_state.dart';

class CustomerServisFormCubit extends Cubit<CustomerServisFormState> {
  CustomerServisFormCubit() : super(CustomerServisFormInitial());
}
