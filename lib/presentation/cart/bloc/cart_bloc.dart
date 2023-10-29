import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/models.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const _Success([])) {
    on<_Add>((event, emit) {
      final currentState = state as _Success;

      final index = currentState.carts
          .indexWhere((e) => e.product.id == event.cart.product.id);

      if (index >= 0) {
        currentState.carts[index].quantity += 1;
        emit(const _Loading());
        emit(_Success(currentState.carts));
      } else {
        emit(_Success([...currentState.carts, event.cart]));
      }
    });

    on<_Substract>((event, emit) {
      final currentState = state as _Success;

      final index = currentState.carts
          .indexWhere((e) => e.product.id == event.cart.product.id);

      if (index >= 0) {
        currentState.carts[index].quantity -= 1;

        if (currentState.carts[index].quantity <= 0) {
          currentState.carts.removeAt(index);
        }

        emit(const _Loading());
        emit(_Success(currentState.carts));
      }
    });

    on<_Remove>((event, emit) {
      final currentState = state as _Success;

      final index = currentState.carts
          .indexWhere((e) => e.product.id == event.cart.product.id);
      // print(index);

      // print(currentState.carts);
      // currentState.carts.removeLast();

      emit(const _Loading());
      // https://github.com/SachienRaj/bliss_shopping/blob/master/lib/modules/cart/bloc/cart_bloc.dart
      emit(_Success(List.from(currentState.carts)..removeAt(index)));
    });
  }
}
