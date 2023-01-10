import 'package:flutter/material.dart';
import 'package:micro_core/apps/micro_app.dart';

import 'micro_core_utils.dart';

abstract class BaseApp {
  // registrando os microApps para que saiba que eles existem
  List<MicroApp> get microApps;

  // caso o projeto tenha navegação interna, será declarado aqui no baseRoutes
  Map<String, WidgetBuilderArgs> get baseRoutes;

  // registra os baseRoutes e microApps
  final Map<String, WidgetBuilderArgs> routes = {};

  void registerRouters() {
    if (baseRoutes.isNotEmpty) {
      routes.addAll(baseRoutes);
    }

    if (microApps.isNotEmpty) {
      for (MicroApp microapp in microApps) {
        routes.addAll(microapp.routes);
      }
    }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    var routerName = settings.name;
    var routerArgs = settings.arguments ?? Object();

    var navigateTo = routes[routerName];
    if (navigateTo == null) {
      return null;
    }

    return MaterialPageRoute(
      builder: (context) => navigateTo.call(context, routerArgs),
    );
  }
}
