import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery_product/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import '../../home/models/product_data_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitialState()) {
      on<WishlistInitialEvent>(wishlistInitialEvent);
      on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
  emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(WishlistRemoveFromWishlistEvent event, Emitter<WishlistState> emit) {
   wishlistItems.remove(event.productDataModel);

   emit(WishlistRemovedActionState());
    emit(WishlistSuccessState(wishlistItems: wishlistItems)) ;
  }
}
