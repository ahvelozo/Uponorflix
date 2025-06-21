import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      path: '/catalog',
      name: RouteNames.catalog,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: SplashPage()),
      routes: [
        GoRoute(
          path: 'new',
          name: RouteNames.movieNew,
          pageBuilder: (context, state) =>
              const MaterialPage(child: SplashPage()),
        ),
        GoRoute(
          path: ':id/edit',
          name: RouteNames.movieEdit,
          // Pass the movie id down to the page;
          // the page decides if it's add or edit
          pageBuilder: (context, state) {
            // final movieId = state.pathParameters['id']!;
            return const MaterialPage(
              child: SplashPage(),
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
  static const catalog = 'catalog';
  static const movieNew = 'movie_new';
  static const movieEdit = 'movie_edit';
}
