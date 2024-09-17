import 'package:firesafe_vnex/app/advisory/advisory.view.dart';
import 'package:firesafe_vnex/app/compare/compare.view.dart';
import 'package:firesafe_vnex/app/in_construction/in_construction.view.dart';
import 'package:firesafe_vnex/app/landing/landing.view.dart';
import 'package:firesafe_vnex/app/laws/laws.view.dart';
import 'package:firesafe_vnex/app/main/add_product/add_product.cubit.dart';
import 'package:firesafe_vnex/app/main/add_product/add_product.view.dart';
import 'package:firesafe_vnex/app/main/cart/cart.view.dart';
import 'package:firesafe_vnex/app/main/chat/chat.view.dart';
import 'package:firesafe_vnex/app/main/home/category/category.cubit.dart';
import 'package:firesafe_vnex/app/main/home/category/category.view.dart';
import 'package:firesafe_vnex/app/main/home/search/filter/filter.view.dart';
import 'package:firesafe_vnex/app/main/home/search/search.cubit.dart';
import 'package:firesafe_vnex/app/main/home/search/search.view.dart';
import 'package:firesafe_vnex/app/main/main.shell.dart';
import 'package:firesafe_vnex/app/main/profile/profile.cubit.dart';
import 'package:firesafe_vnex/app/main/profile/profile.view.dart';
import 'package:firesafe_vnex/app/market_report/market_report.view.dart';
import 'package:firesafe_vnex/app/news/detail/news.detail.cubit.dart';
import 'package:firesafe_vnex/app/news/detail/news.detail.view.dart';
import 'package:firesafe_vnex/app/news/news.cubit.dart';
import 'package:firesafe_vnex/app/news/news.view.dart';
import 'package:firesafe_vnex/app/product_detail/product_detail.cubit.dart';
import 'package:firesafe_vnex/app/product_detail/product_detail.view.dart';
import 'package:firesafe_vnex/app/project_info/project_info.view.dart';
import 'package:firesafe_vnex/app/sign_in/sign_in.cubit.dart';
import 'package:firesafe_vnex/app/sign_in/sign_in.view.dart';
import 'package:firesafe_vnex/app/sign_up/sign_up.cubit.dart';
import 'package:firesafe_vnex/app/sign_up/sign_up.view.dart';
import 'package:firesafe_vnex/app/splash/splash.view.dart';
import 'package:firesafe_vnex/app/supplier/supplier_info.cubit.dart';
import 'package:firesafe_vnex/app/supplier/supplier_info.view.dart';
import 'package:firesafe_vnex/utils/extensions/context.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../app/main/home/home.view.dart';

const routes = (
  root: '/',
  landing: '/landing',
  signIn: '/sign-in',
  signUp: '/sign-up',
  initialSetup: '/initial-setup',
  home: '/home',
  news: '/news',
  marketReport: '/market-report',
  laws: '/laws',
  advisory: '/advisory',
  projectInfo: '/project-information',
  compare: '/compare',
  search: 'search',
  filter: 'filter',
  addProduct: '/add-product',
  cart: '/cart',
  chat: '/chat',
  moreScreen: '/more',
  detail: '/product/:id',
  supplierInfo: '/supplier-info/:id',
  category: 'category/:id',
  newsDetail: 'newsDetail/:id'
);

final _rootNavigator = GlobalKey<NavigatorState>();
final _shellNavigator = GlobalKey<NavigatorState>();

final routerConfigs = GoRouter(
  initialLocation: routes.root,
  navigatorKey: _rootNavigator,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: routes.root,
      path: routes.root,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: routes.landing,
      path: routes.landing,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return const LandingScreen();
      },
    ),
    GoRoute(
      name: routes.signIn,
      path: routes.signIn,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return BlocProvider(
          create: (context) {
            return SignInCubit(context.getRepo());
          },
          child: const SignInScreen(),
        );
      },
    ),
    GoRoute(
      name: routes.signUp,
      path: routes.signUp,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => SignUpCubit(context.getRepo()),
          child: const SignUpScreen(),
        );
      },
    ),
    GoRoute(
      name: routes.supplierInfo,
      path: routes.supplierInfo,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => SupplierInfoCubit(context.getRepo(), state.pathParameters['id'].toString()),
          child: const SupplierInfoScreen(),
        );
      },
    ),
    GoRoute(
      name: routes.detail,
      path: routes.detail,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ProductDetailCubit(
            context.getRepo(),
            context.getRepo(),
            state.pathParameters['id'].toString(),
          ),
          child: const ProductDetail(),
        );
      },
    ),
    GoRoute(
      path: '/in-construction',
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return const InConstructionScreen();
      },
    ),
    GoRoute(
        name: routes.news,
        path: routes.news,
        parentNavigatorKey: _rootNavigator,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => NewsCubit(context.getRepo()),
            child: const NewsScreen(),
          );
        },
        routes: [
          GoRoute(
            name: routes.newsDetail,
            path: routes.newsDetail,
            parentNavigatorKey: _rootNavigator,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => NewsDetailCubit(context.getRepo(), state.pathParameters['id'].toString()),
                child: const NewsDetailScreen(),
              );
            },
          ),
        ]),
    GoRoute(
      name: routes.marketReport,
      path: routes.marketReport,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return const MarketReportScreen();
      },
    ),
    GoRoute(
      name: routes.laws,
      path: routes.laws,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return const LawsScreen();
      },
    ),
    GoRoute(
      name: routes.advisory,
      path: routes.advisory,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return const AdvisorScreen();
      },
    ),
    GoRoute(
      name: routes.projectInfo,
      path: routes.projectInfo,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return const ProjectInfoScreen();
      },
    ),
    GoRoute(
      name: routes.compare,
      path: routes.compare,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return const CompareScreen();
      },
    ),
    GoRoute(
      name: routes.addProduct,
      path: routes.addProduct,
      parentNavigatorKey: _rootNavigator,
      builder: (context, state) {
        return BlocProvider<AddProductCubit>(
          create: (context) {
            return AddProductCubit(context.getRepo(), context.getRepo());
          },
          child: const AddProductScreen(),
        );
      },
    ),
    ShellRoute(
      parentNavigatorKey: _rootNavigator,
      navigatorKey: _shellNavigator,
      builder: (context, state, widget) {
        return MainShell(
          child: widget,
        );
      },
      routes: [
        GoRoute(
          name: routes.home,
          path: routes.home,
          builder: (context, state) {
            return const HomeScreen();
          },
          routes: [
            GoRoute(
              name: routes.search,
              path: routes.search,
              parentNavigatorKey: _rootNavigator,
              builder: (context, state) {
                return BlocProvider<SearchCubit>(
                  create: (context) {
                    return SearchCubit(context.getRepo());
                  },
                  child: const SearchScreen(),
                );
              },
              routes: [
                GoRoute(
                  name: routes.filter,
                  path: routes.filter,
                  parentNavigatorKey: _rootNavigator,
                  builder: (context, state) {
                    return const FilterScreen();
                  },
                ),
              ],
            ),
            GoRoute(
              name: routes.category,
              path: routes.category,
              parentNavigatorKey: _rootNavigator,
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => CategoryCubit(context.getRepo(), state.pathParameters['id'].toString()),
                  child: const CategoryScreen(),
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: routes.cart,
          path: routes.cart,
          parentNavigatorKey: _shellNavigator,
          builder: (context, state) {
            return const CartScreen();
          },
        ),
        GoRoute(
            name: routes.chat,
            path: routes.chat,
            parentNavigatorKey: _shellNavigator,
            builder: (context, state) {
              return const ChatScreen();
            }),
        GoRoute(
          name: routes.moreScreen,
          path: routes.moreScreen,
          parentNavigatorKey: _shellNavigator,
          builder: (context, state) {
            return BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(context.getRepo()),
              child: const ProfileScreen(),
            );
          },
        ),
      ],
    ),
  ],
);
