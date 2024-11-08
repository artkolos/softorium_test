import 'package:auto_route/auto_route.dart';
import 'package:softorium_test/presentation/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AdaptiveRoute(
          page: MainFlow.page,
          initial: true,
          children: [
            AdaptiveRoute(
              page: MainRoute.page,
              path: '',
              children: [
                AdaptiveRoute(
                  page: HomeRoute.page,
                  path: '',
                ),
                AdaptiveRoute(
                  page: NotificationRoute.page,
                ),
                AdaptiveRoute(
                  page: ChartRoute.page,
                ),
                AdaptiveRoute(
                  page: CardRoute.page,
                ),
                AdaptiveRoute(
                  page: PersonRoute.page,
                )
              ],
            ),
          ],
        ),
      ];
}
