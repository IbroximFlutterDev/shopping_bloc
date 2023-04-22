part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}
abstract class WishlistActionState extends WishlistState{}

class WishlistInitialState extends WishlistState {}
class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishlistItems;

  WishlistSuccessState({required this.wishlistItems});
}


class WishlistRemovedActionState extends WishlistActionState{}