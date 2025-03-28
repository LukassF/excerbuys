import 'package:excerbuys/components/dashboard_page/home_page/shop_item_card.dart';
import 'package:excerbuys/components/shared/loaders/universal_loader_box.dart';
import 'package:excerbuys/components/shared/indicators/current_item/current_item_indicator.dart';
import 'package:excerbuys/store/controllers/layout_controller.dart';
import 'package:excerbuys/utils/constants.dart';
import 'package:flutter/material.dart';

class ProgressOffersContainer extends StatefulWidget {
  final bool? isLoading;
  const ProgressOffersContainer({super.key, this.isLoading});

  @override
  State<ProgressOffersContainer> createState() =>
      _ProgressOffersContainerState();
}

class _ProgressOffersContainerState extends State<ProgressOffersContainer> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPercent = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final itemWidth = layoutController.relativeContentWidth;
    final scrollOffset = _scrollController.offset;

    setState(() {
      _scrollPercent = (scrollOffset / itemWidth);
    });
  }

  Widget get loadingContainer {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: HORIZOTAL_PADDING),
      child: UniversalLoaderBox(
          height: 220,
          width: MediaQuery.sizeOf(context).width - 2 * HORIZOTAL_PADDING),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(bottom: 2 * HORIZOTAL_PADDING),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: HORIZOTAL_PADDING),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nearly there, keep going', style: texts.headlineLarge),
              ],
            ),
          ),
          widget.isLoading == true
              ? loadingContainer
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: 250,
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          physics: const PageScrollPhysics(),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return _buildShopItemCard(index);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 1st one -> 1 - _scrollPercent
                        // others -> _scrollPercent <= index ? _scrollPercent + 1 - index : index + 1 - _scrollPercent
                        CurrentItemIndicator(activePercent: 1 - _scrollPercent),
                        CurrentItemIndicator(
                            activePercent: _scrollPercent <= 1
                                ? _scrollPercent
                                : 2 - _scrollPercent),
                        CurrentItemIndicator(
                            activePercent: _scrollPercent <= 2
                                ? _scrollPercent - 1
                                : 3 - _scrollPercent),
                        CurrentItemIndicator(
                            activePercent: _scrollPercent <= 3
                                ? _scrollPercent - 2
                                : 4 - _scrollPercent),
                        CurrentItemIndicator(
                            activePercent: _scrollPercent <= 4
                                ? _scrollPercent - 3
                                : 5 - _scrollPercent),
                        CurrentItemIndicator(activePercent: _scrollPercent - 4),
                      ],
                    )
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildShopItemCard(int index) {
    switch (index) {
      case 0:
        return ShopItemCard(
          image:
              'https://img.freepik.com/free-vector/cute-panda-lifting-barbell-gym-fitness-cartoon-vector-icon-illustration-animal-sports-icon-isolated_138676-5482.jpg',
          points: 25000,
          originalPrice: 58,
          name: 'Avocado protein',
          seller: 'Producer AC',
          discount: 12,
          progress: 90,
        );
      case 1:
        return ShopItemCard(
          image: 'https://rmggym.pl/layout/images/kluby/Bydgoszcz01.png',
          originalPrice: 65,
          discount: 15,
          points: 185000,
          name: 'Gym membership',
          seller: 'Just Gym',
          progress: 30,
        );
      case 2:
        return ShopItemCard(
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE4Dxz-qvNcRTxdZWLFGzkoi5VF0hYXihscQ&s',
          originalPrice: 22,
          discount: 15,
          points: 185000,
          name: 'Gym membership 1 month',
          seller: 'Platinum',
          progress: 60,
        );
      case 3:
        return ShopItemCard(
          image:
              'https://marketplace.canva.com/EAFxdcos7WU/1/0/1600w/canva-dark-blue-and-brown-illustrative-fitness-gym-logo-oqe3ybeEcQQ.jpg',
          points: 250000,
          originalPrice: 58,
          name: 'Chocolate protein',
          seller: 'Producer AC',
          discount: 12,
          progress: 50,
        );
      case 4:
        return ShopItemCard(
          image: 'https://rmggym.pl/layout/images/kluby/Bydgoszcz01.png',
          originalPrice: 65,
          discount: 15,
          points: 185000,
          name: 'Gym membership',
          seller: 'Just Gym',
          progress: 70,
        );
      case 5:
        return ShopItemCard(
          image:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE4Dxz-qvNcRTxdZWLFGzkoi5VF0hYXihscQ&s',
          originalPrice: 22,
          discount: 15,
          points: 185000,
          name: 'Gym membership 1 month',
          seller: 'Platinum',
          isLast: true,
          progress: 70,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
