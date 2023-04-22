import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_product/features/cart/bloc/cart_bloc.dart';
import 'package:grocery_product/features/cart/ui/cart_tile_widget.dart';
import 'package:grocery_product/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:grocery_product/features/wishlist/ui/wishlist_tile_widget.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist items'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listener: (context, state) {
          if (state is WishlistRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item deleted')),
            );
          }
        },
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                itemCount: successState.wishlistItems.length,
                itemBuilder: (context, index) {
                  return WishlistTileWidget(
                    wishlistBloc: wishlistBloc,
                    productDataModel: successState.wishlistItems[index],
                  );
                },
              );
          }
          return Container();
        },
      ),
    );
  }
}
