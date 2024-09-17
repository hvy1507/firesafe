import 'package:firesafe_vnex/repository/country.repo.dart';
import 'package:firesafe_vnex/repository/impl/country.repo.impl.dart';
import 'package:firesafe_vnex/repository/impl/newspaper.repo.impl.dart';
import 'package:firesafe_vnex/repository/impl/product.repo.impl.dart';
import 'package:firesafe_vnex/repository/impl/supplier.repo.impl.dart';
import 'package:firesafe_vnex/repository/impl/user.repo.impl.dart';
import 'package:firesafe_vnex/repository/newspaper.repo.dart';
import 'package:firesafe_vnex/repository/product.repo.dart';
import 'package:firesafe_vnex/repository/supplier.repo.dart';
import 'package:firesafe_vnex/repository/user.repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication.repo.dart';
import '../impl/authentication.repo.impl.dart';

final repoProviders = [
  RepositoryProvider<AuthenticationRepository>(
    create: (context) {
      return AuthenticationRepositoryImpl();
    },
  ),
  RepositoryProvider<ProductRepository>(
    create: (context) {
      return ProductRepositoryImpl();
    },
  ),
  RepositoryProvider<UserRepository>(
    create: (context) {
      return UserRepositoryImpl();
    },
  ),
  RepositoryProvider<SupplierRepository>(
    create: (context) {
      return SupplierRepositoryImpl();
    },
  ),
  RepositoryProvider<NewspaperRepository>(
    create: (context) {
      return NewspaperRepositoryImpl();
    },
  ),
  RepositoryProvider<CountryRepository>(
    create: (context) {
      return CountryRepositoryImpl();
    },
  ),
];
