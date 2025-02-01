import 'dart:math';
import 'dart:ui';

import 'package:excerbuys/store/controllers/dashboard_controller.dart';
import 'package:excerbuys/store/controllers/layout_controller.dart';
import 'package:excerbuys/utils/constants.dart';
import 'package:excerbuys/wrappers/ripple_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return StreamBuilder<double>(
        stream: dashboardController.scrollDistanceStream,
        builder: (context, snapshot) {
          return StreamBuilder(
              stream: dashboardController.activePageStream,
              builder: (context, pageSnapshot) {
                final bool isActive =
                    snapshot.hasData && snapshot.data! > 275 ||
                        pageSnapshot.data != 0;

                return Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 150),
                      curve: Curves.decelerate,
                      padding: EdgeInsets.only(
                          left: HORIZOTAL_PADDING * 2,
                          right: HORIZOTAL_PADDING * 2,
                          top: layoutController.statusBarHeight),
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: colors.primary.withAlpha(isActive ? 255 : 0),
                      ),
                      height: 80 + layoutController.statusBarHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RippleWrapper(
                            onPressed: () {},
                            child: Container(
                              child: SvgPicture.asset(
                                'assets/svg/menu.svg',
                                height: 35,
                                colorFilter: ColorFilter.mode(
                                    isActive ? colors.tertiary : colors.primary,
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                          // Row(children: [
                          //   RippleWrapper(
                          //     onPressed: () {},
                          //     child: Stack(
                          //       children: [
                          //         Container(
                          //           padding: EdgeInsets.symmetric(
                          //               vertical: 10, horizontal: 7),
                          //           child: SvgPicture.asset(
                          //             'assets/svg/shopping-basket.svg',
                          //             height: 28,
                          //             colorFilter: ColorFilter.mode(
                          //                 Theme.of(context).colorScheme.tertiary,
                          //                 BlendMode.srcIn),
                          //           ),
                          //         ),
                          //         Positioned(
                          //             left: 5,
                          //             top: 9,
                          //             child: Container(
                          //               width: 12,
                          //               height: 12,
                          //               decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(100),
                          //                   color: Theme.of(context)
                          //                       .colorScheme
                          //                       .secondary),
                          //             )),
                          //       ],
                          //     ),
                          //   ),
                          //   RippleWrapper(
                          //     onPressed: () {},
                          //     child: Stack(
                          //       children: [
                          //         Container(
                          //           padding:
                          //               EdgeInsets.only(top: 10, bottom: 10, left: 7),
                          //           child: SvgPicture.asset(
                          //             'assets/svg/bell.svg',
                          //             height: 25,
                          //             colorFilter: ColorFilter.mode(
                          //                 Theme.of(context).colorScheme.tertiary,
                          //                 BlendMode.srcIn),
                          //           ),
                          //         ),
                          //         Positioned(
                          //             left: 8,
                          //             top: 7,
                          //             child: Container(
                          //               width: 12,
                          //               height: 12,
                          //               decoration: BoxDecoration(
                          //                   borderRadius: BorderRadius.circular(100),
                          //                   color: Theme.of(context)
                          //                       .colorScheme
                          //                       .secondary),
                          //             )),
                          //       ],
                          //     ),
                          //   ),
                          // ])
                        ],
                      ),
                    ),
                    Positioned(
                      top: isActive
                          ? 28 + layoutController.statusBarHeight
                          : 80 + layoutController.statusBarHeight,
                      right: 24,
                      child: Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            '13909 points',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.tertiary),
                          )),
                    )
                  ],
                );
              });
        });
  }
}
