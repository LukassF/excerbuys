import 'dart:ui';

import 'package:excerbuys/components/shared/buttons/appbar_icon_button.dart';
import 'package:excerbuys/pages/dashboard_subpages/home_page.dart';
import 'package:excerbuys/store/controllers/dashboard_controller.dart';
import 'package:excerbuys/store/controllers/layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return StreamBuilder<int>(
        stream: dashboardController.activePageStream,
        builder: (context, snapshot) {
          return Stack(
            children: [
              Container(
                height: 80 + layoutController.bottomPadding,
                padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: layoutController.bottomPadding,
                    top: 16),
                decoration: BoxDecoration(
                  color: colors.primary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppbarIconButton(
                      icon: 'assets/svg/home.svg',
                      onPressed: () {
                        dashboardController.setActivePage(0);
                      },
                      isActive: snapshot.data == 0,
                    ),
                    AppbarIconButton(
                      icon: 'assets/svg/search.svg',
                      onPressed: () {
                        dashboardController.setActivePage(1);
                      },
                      isActive: snapshot.data == 1,
                    ),
                    AppbarIconButton(
                      icon: 'assets/svg/tag.svg',
                      onPressed: () {
                        dashboardController.setActivePage(2);
                      },
                      isActive: snapshot.data == 2,
                    ),
                    AppbarIconButton(
                      icon: 'assets/svg/profile.svg',
                      onPressed: () {
                        dashboardController.setActivePage(3);
                      },
                      isActive: snapshot.data == 3,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.decelerate,
                  left: MediaQuery.sizeOf(context).width / 2 -
                      145 +
                      ((snapshot.data ?? 0) * 80),
                  top: 0,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10), top: Radius.circular(3)),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )),
            ],
          );
        });
  }
}
