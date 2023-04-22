import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_product/data/grocery_data.dart';
import 'package:grocery_product/features/home/ui/product_tile_widget.dart';
import 'package:grocery_product/screens/splash_screen.dart';

import '../../cart/ui/cart.dart';
import '../../wishlist/ui/wishlist.dart';
import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Cart()),
          );
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Wishlist()),
          );
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item is carted'),
              duration: Duration(seconds: 3),
            ),
          );
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item is wishlisted'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: SplashScreen(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.favorite,color: Colors.red,),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(Icons.shopping_cart_sharp),
                  ),
                ],
                title: const Text('Online shopping app'),
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                    homeBloc: homeBloc,
                    productDataModel: successState.products[index],
                  );
                },
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text(
                  'Error',
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
