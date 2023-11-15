import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/order_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/orderDetail/order_detail_response_model.dart';

part 'buyer_order_event.dart';
part 'buyer_order_state.dart';
part 'buyer_order_bloc.freezed.dart';

class BuyerOrderBloc extends Bloc<BuyerOrderEvent, BuyerOrderState> {
  BuyerOrderBloc() : super(const _Initial()) {
    on<_RetrieveBuyerOrder>((event, emit) async {
      emit(const _Loading());

      final response = await OrderRemoteDataSource().retrieveOrderByBuyerId();

      response.fold(
        (failure) => emit(_Failed(failure)),
        (result) => emit(_Success(result)),
      );
    });
  }
}
