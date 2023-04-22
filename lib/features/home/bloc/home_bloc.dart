import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery_product/data/cart_items.dart';
import 'package:grocery_product/data/grocery_data.dart';
import 'package:grocery_product/data/wishlist_items.dart';

import '../models/product_data_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emitter) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(
      HomeLoadedSuccessState(
        products: GroceryData.groceryProducts.map(
          (e) {
            return ProductDataModel(
              id: e['id'],
              name: e['name'],
              description: e['description'],
              price: e['price'],
              imageUrl: e['imageUrl'],
            );
          },
        ).toList(),
      ),
    );
  }

  //this two for appbar icons
  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emitter) {
    print('wishlist clicked for navigation');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emitter) {
    print('cart clicked for navigation');
    emit(HomeNavigateToCartPageActionState());
  }

  //this two for body icons
  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emitter) {
    print('Wishlist button clicked in product not in appbar');
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emitter) {
    print('Cart button clicked in product not in appbar');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }
}
