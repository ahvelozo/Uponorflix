import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uponorflix/catalogs/add_edit_video/view/add_edit_video_page.dart';
import 'package:uponorflix/catalogs/catalogs/view/catalog_page.dart';
import 'package:uponorflix/catalogs/home/view/catalog_page.dart';
import 'package:uponorflix/splash/splash.dart';

/// Centralised GoRouter configuration for Uponorflix.
///
/// Route structure
///  /                -> SplashPage
///  /catalog         -> CatalogPage (list of movies)
///  /catalog/new     -> AddEditMoviePage (add mode)
///  /catalog/:id/edit -> AddEditMoviePage (edit mode)
///
/// All route names are collected in [RouteNames] for type‑safe navigation:
///   context.goNamed(RouteNames.catalog);
///   context.goNamed(RouteNames.movieEdit, params: {'id': movie.id});
///
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true, // useful while developing; disable in prod
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.splash,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SplashPage()),
    ),
    GoRoute(
      path: '/home',
      name: RouteNames.home,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomePage()),
    ),
    GoRoute(
      path: '/catalog',
      name: RouteNames.catalog,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: CatalogPage()),
      routes: [
        GoRoute(
          path: 'new',
          name: RouteNames.videoNew,
          pageBuilder: (context, state) =>
              const MaterialPage(child: AddEditVideoPage()),
        ),
        GoRoute(
          path: ':id/edit',
          name: RouteNames.videoEdit,
          // Pass the video id down to the page;
          // the page decides if it's add or edit
          pageBuilder: (context, state) {
            final videoId = state.pathParameters['id']!;
            return MaterialPage(
              child: AddEditVideoPage(
                videoId: videoId,
              ),
            );
          },
        ),
      ],
    ),
  ],
  // Simple error / 404 page.
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri}'),
    ),
  ),
);

/// Centralised list of route names to avoid typos.
abstract class RouteNames {
  static const splash = 'splash';
  static const home = 'home';
  static const catalog = 'catalog';
  static const videoNew = 'video_new';
  static const videoEdit = 'video_edit';
}
