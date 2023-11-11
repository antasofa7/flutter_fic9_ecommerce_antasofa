import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/order_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/getAddress/get_address_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/addAddress/add_address_response_model.dart';

part 'get_address_event.dart';
part 'get_address_state.dart';
part 'get_address_bloc.freezed.dart';

class GetAddressBloc extends Bloc<GetAddressEvent, GetAddressState> {
  GetAddressBloc() : super(const _Initial()) {
    on<_RetrieveAddressByUserId>((event, emit) async {
      emit(const _Loading());
      final response = await OrderRemoteDataSource().retrieveAddressByUserId();

      response.fold(
        (failure) => emit(_Failed(failure)),
        (result) => emit(_Success(result)),
      );
    });

    on<_GetSelectedAddress>((event, emit) async {
      emit(const _Loading());
      final response = await AuthLocalDatasource().getAddress();

      if (response != null) {
        emit(_Select(response));
      } else {
        final res = await OrderRemoteDataSource().retrieveAddressByUserId();
        res.fold((failure) => emit(_Failed(failure)), (result) {
          var address = result.data!
              .where(
                (e) => e.attributes!.is_default == true,
              )
              .toList();
          emit(_Select(address.first));
        });
      }

      // response.fold(
      //   (failure) => emit(_Failed(failure)),
      //   (result) => emit(_Success(result)),
      // );
    });
  }
}
