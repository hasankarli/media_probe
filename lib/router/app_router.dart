import 'package:flutter/material.dart';
import 'package:media_probe/models/popular_response.dart';
import 'package:media_probe/router/routes.dart';

import '../article_detail_screen.dart';
import '../home_screen.dart';

class AppRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.articleDetail:
        return MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(
                  popular: routeSettings.arguments as Popular,
                ));
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
