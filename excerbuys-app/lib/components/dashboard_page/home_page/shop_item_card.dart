import 'package:excerbuys/store/controllers/dashboard_controller.dart';
import 'package:excerbuys/utils/constants.dart';
import 'package:excerbuys/utils/parsers/parsers.dart';
import 'package:excerbuys/wrappers/ripple_wrapper.dart';
import 'package:flutter/material.dart';

class ShopItemCard extends StatefulWidget {
  final bool? isLast;
  final String image;
  final double originalPrice;
  final int discount;
  final int points;
  final String name;
  final String seller;
  final double? progress;

  const ShopItemCard(
      {super.key,
      this.isLast,
      required this.image,
      required this.originalPrice,
      required this.discount,
      required this.points,
      required this.name,
      required this.seller,
      this.progress});

  @override
  State<ShopItemCard> createState() => _ShopItemCardState();
}

class _ShopItemCardState extends State<ShopItemCard> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme;

    final isProgress = widget.progress != null && widget.progress! < 100;

    return Container(
        width: MediaQuery.sizeOf(context).width,
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: HORIZOTAL_PADDING),
        child: RippleWrapper(
            onPressed: () {},
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            isProgress ? Colors.grey : Colors.transparent,
                            BlendMode.saturation),
                        child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                              color: colors.primary,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(widget.image),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withAlpha(220),
                                Colors.transparent
                              ],
                              stops: [
                                0.2,
                                0.8
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter)),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: texts.headlineMedium?.copyWith(
                                            color: colors.primary,
                                          ),
                                        ),
                                        Text(
                                          widget.seller,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                            color: colors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${widget.discount.toString()}%',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: colors.secondary,
                                          ),
                                        ),
                                        StreamBuilder<bool>(
                                            stream: dashboardController
                                                .balanceHiddenStream,
                                            builder: (context, snapshot) {
                                              final bool isHidden =
                                                  snapshot.data ?? false;
                                              return Text(
                                                isHidden
                                                    ? '***** finpoints'
                                                    : '${formatNumber(widget.points)} finpoints',
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: colors.secondary,
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            widget.progress != null
                                ? progressBar(widget.progress!, colors)
                                : SizedBox.shrink()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                isProgress
                    ? StreamBuilder<bool>(
                        stream: dashboardController.balanceHiddenStream,
                        builder: (context, snapshot) {
                          final bool isHidden = snapshot.data ?? false;
                          return Container(
                            margin: const EdgeInsets.only(
                                right: HORIZOTAL_PADDING, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  isHidden
                                      ? 'Only ***** finpoints to go!'
                                      : 'Only ${formatNumber((((100 - widget.progress!) / 100) * widget.points).round())} finpoints to go!',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: colors.tertiaryContainer,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          );
                        })
                    : SizedBox.shrink(),
              ],
            )));
  }
}

Widget progressBar(double progress, ColorScheme colors) {
  return Container(
    height: 3,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: colors.secondary.withAlpha(70),
    ),
    child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: [
            Container(
              width: (progress / 100) * constraints.maxWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors.secondary,
              ),
            ),
          ],
        );
      },
    ),
  );
}
