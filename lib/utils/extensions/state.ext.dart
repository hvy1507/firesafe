import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension StateExtension on State {
  T getRepo<T>() {
    return RepositoryProvider.of<T>(context);
  }

  T getCubit<T extends Cubit>() {
    return BlocProvider.of<T>(context);
  }
}
