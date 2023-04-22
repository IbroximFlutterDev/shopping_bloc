import 'package:flutter/material.dart';
import 'package:grocery_product/features/home/bloc/home_bloc.dart';
import 'package:grocery_product/features/home/models/product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  const ProductTileWidget({Key? key, required this.productDataModel, required this.homeBloc})
      : super(key: key);
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

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
                      homeBloc.add(HomeProductWishlistButtonClickedEvent(
                        productDataModel
                      ));

                    },
                    icon: const Icon(Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                          HomeProductCartButtonClickedEvent(productDataModel));
                    },
                    icon: const Icon(Icons.add_shopping_cart_sharp),
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
