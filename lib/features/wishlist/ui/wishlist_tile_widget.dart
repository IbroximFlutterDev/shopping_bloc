import 'package:flutter/material.dart';
import 'package:grocery_product/features/cart/bloc/cart_bloc.dart';
import 'package:grocery_product/features/home/models/product_data_model.dart';
import 'package:grocery_product/features/wishlist/bloc/wishlist_bloc.dart';

import '../../home/bloc/home_bloc.dart';

class WishlistTileWidget extends StatelessWidget {
  const WishlistTileWidget(
      {Key? key, required this.productDataModel, required this.wishlistBloc})
      : super(key: key);
  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(productDataModel.imageUrl),
            )),
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            productDataModel.description,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${productDataModel.price}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      wishlistBloc.add(
                        WishlistRemoveFromWishlistEvent(
                            productDataModel: productDataModel),
                      );
                    },
                    icon: const Icon(Icons.favorite_border),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
