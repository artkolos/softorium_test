import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:softorium_test/gen/assets.gen.dart';
import 'package:softorium_test/presentation/main_flow/main_screen/widgets/app_navigation_bar.dart';
import 'package:softorium_test/presentation/main_flow/main_screen/widgets/app_navigation_item.dart';
import 'package:softorium_test/presentation/router/app_router.gr.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF9F3FC),
                Color(0xFFFAF1E7),
              ],
            ),
          ),
        ),
        AutoTabsRouter.pageView(
          routes: const <PageRouteInfo>[
            HomeRoute(),
            CardRoute(),
            ChartRoute(),
            NotificationRoute(),
            PersonRoute(),
          ],
          builder: (context, child, _) {
            final tabsRouter = AutoTabsRouter.of(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                toolbarHeight: 0,
                backgroundColor: Colors.transparent,
              ),
              backgroundColor: Colors.transparent,
              body: child,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                ),
                child: AppNavigationBar(
                  items: [
                    AppNavigationItem(
                      onTap: () => tabsRouter.setActiveIndex(0),
                      icon: SvgPicture.asset(
                        Assets.icons.homeIcon,
                      ),
                      isActive: tabsRouter.activeIndex == 0,
                    ),
                    AppNavigationItem(
                      onTap: () => tabsRouter.setActiveIndex(1),
                      icon: SvgPicture.asset(
                        Assets.icons.cardIcon,
                      ),
                      isActive: tabsRouter.activeIndex == 1,
                    ),
                    AppNavigationItem(
                      onTap: () => tabsRouter.setActiveIndex(2),
                      icon: SvgPicture.asset(
                        Assets.icons.chartIcon,
                      ),
                      isActive: tabsRouter.activeIndex == 2,
                    ),
                    AppNavigationItem(
                      onTap: () => tabsRouter.setActiveIndex(3),
                      icon: SvgPicture.asset(
                        Assets.icons.notificationIcon,
                      ),
                      isActive: tabsRouter.activeIndex == 3,
                    ),
                    AppNavigationItem(
                      onTap: () => tabsRouter.setActiveIndex(4),
                      icon: const Icon(
                        Icons.person_3_outlined,
                      ),
                      isActive: tabsRouter.activeIndex == 4,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
