import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eccomerce/controllers/product_controller.dart';
import 'package:flutter_eccomerce/views/cart_page.dart';
import 'package:flutter_eccomerce/views/home_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../constans/themes.dart';

class DetailsPage extends ConsumerWidget {
   DetailsPage({super.key, required this.getIndex});

  int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final product = ref.watch(productNotifierProvider);
    return Scaffold(appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text('Details page'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(onPressed: () {
              
            }, icon: Icon(Icons.local_mall)))
        ],
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                color: kLightBackground,
                child: Image.asset(product[getIndex].imgUrl),
                ),

                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product[getIndex].title,
                        style: AppTheme.kBigTitle.copyWith(color: kPrimaryColor),
                        ),
                        Gap(12),
                      Row(
                        children: [
                          RatingBar(
                            itemSize: 20,
                            initialRating: 1,
                            minRating: 1,
                            maxRating: 5,
                            allowHalfRating: true,
                            ratingWidget: RatingWidget(
                            empty: const Icon(
                              Icons.star_border,
                              color: Colors.amber,
                              ),
                            full: Icon(
                              Icons.star,
                              color: Colors.amber,
                              ),
                            half: Icon(
                              Icons.star_half_sharp,
                              color: Colors.amber,
                              ),
                            ), 
                            onRatingUpdate: (value) => null,
                            ),
                            const Gap(12),
                            const Text('125 review'),
                        ],
                      ),
                      const Gap(8),
                       Text(product[getIndex].longDescription),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(
                          '\$${product[getIndex].price * product[getIndex].qty}',
                          style: AppTheme.kHeadingOne,
                          ),
                        Container(
                          child: Row(
                            children: [
                                  IconButton(
                                    onPressed: () {
                                      ref
                                      .read(productNotifierProvider.notifier)
                                      .decreaseQty(product[getIndex].pid);
                                    }, 
                                    icon: Icon(
                                      Icons.do_not_disturb_on_outlined,
                                      size: 30,
                                      ),
                                    ),
                                    Text(
                                      product[getIndex].qty.toString(), 
                                      style: AppTheme.kCardTitle.copyWith(fontSize: 24),
                                    ),

                                    IconButton(
                                      onPressed: (){
                                        ref
                                      .read(productNotifierProvider.notifier)
                                      .incrementQty(product[getIndex].pid);
                                      },
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        size: 30,
                                        ),
                                      ),
                            ],
                            ),
                            ),   
                      ],
                      ),

                       ElevatedButton(
                           style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            minimumSize: Size(double.infinity, 50),
                            ),
                              onPressed: (){}, 
                              child: Text('Add Item To Bag'),
                              ),
                  ],
                  ),
                ),
          ],
          ),
        ),

        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) => ref.read(currentIndexProvider.notifier).update((state) => value),
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kSecondaryColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                activeIcon: Icon(Icons.home_filled),
                ),

                 BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outlined),
                label: 'Favorite',
                activeIcon: Icon(Icons.favorite),
                ),

                 BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                label: 'Location',
                activeIcon: Icon(Icons.location_on),
                ),

                 BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined),
                label: 'Notification',
                activeIcon: Icon(Icons.notifications),
                ),

                 BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                label: 'Profile',
                activeIcon: Icon(Icons.person),
                ),
          ],
          ),
        );
  }
}