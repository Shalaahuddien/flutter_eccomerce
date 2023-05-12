import 'package:flutter/material.dart';
import 'package:flutter_eccomerce/constans/themes.dart';
import 'package:flutter_eccomerce/controllers/itembag_controller.dart';
import 'package:flutter_eccomerce/controllers/product_controller.dart';
import 'package:flutter_eccomerce/views/detail_page.dart';
import 'package:flutter_eccomerce/widgets/card_widget.dart';
import 'package:flutter_eccomerce/widgets/chip_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../widgets/ads_banner_widget.dart';
import 'cart_page.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productNotifierProvider);
    final currentIndex = ref.watch(currentIndexProvider);
    final itemBag = ref.watch(itemBagProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: SvgPicture.asset('assets/general/store_brand_white.svg',
        color: kWhiteColor,
        width: 180,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10,),
            child: Badge(
              label: Text(itemBag.length.toString()),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => CardPage(),
                  ),
                  );
                }, 
                icon: Icon(
                  Icons.local_mall, 
                  size: 24,
                  ),
                  ),
            ))
        ],
        ),
        drawer: const Drawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
            children: [
              // Ads banner section
              const AdsBannerWidget(),
              // chip section
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    ChipWidget(chipLabel: 'All'),
                    ChipWidget(chipLabel: 'Computers'),
                    ChipWidget(chipLabel: 'Headsets'),
                    ChipWidget(chipLabel: 'Accessories'),
                    ChipWidget(chipLabel: 'Printing'),
                    ChipWidget(chipLabel: 'Camers'),
                  ],
                ),
              ),
              //Hot sales section

              const Gap(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Hot Sales',
                style: AppTheme.kHeadingOne
                ),
                Text('See All', 
                style: AppTheme.kSeeAllText,
                ),
              ],
              ),
              
              Container(
                padding: const EdgeInsets.all(4),
                width: double.infinity,
                height: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.all(4),
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                    ProductCardWidget(productIndex: index),
                  ),
              ),
              // Featured products

                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Featured Products',
                style: AppTheme.kHeadingOne
                ),
                Text('See Alls', 
                style: AppTheme.kSeeAllText,
                ),
              ],
              ),

              MasonryGridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                shrinkWrap: true,
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  ), 
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(getIndex: index),
                        ),
                        ),
                    child: SizedBox(
                      height: 250, 
                      child: ProductCardWidget(productIndex: index),
                      ),
                  ),
                    ),
            ],
            ),
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
