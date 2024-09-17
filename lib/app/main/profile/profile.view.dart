import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firesafe_vnex/app/main/profile/profile.cubit.dart';
import 'package:firesafe_vnex/app/main/profile/profile.state.dart';
import 'package:firesafe_vnex/components/resources/resources.dart';
import 'package:firesafe_vnex/components/widgets/error_widget.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/profile_header.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/models/user/user.model.dart';
import 'package:firesafe_vnex/repository/authentication.repo.dart';
import 'package:firesafe_vnex/repository/supplier.repo.dart';
import 'package:firesafe_vnex/routes/app_routes.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileCubit get cubit => getCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(showEdit: state is ProfileLoadedState),
          body: () {
            if (state is ProfileLoadingState) {
              return buildLoading();
            }
            if (state is ProfileErrorState) {
              return FSErrorWidget(
                message: state.message,
                retry: () {
                  cubit.load();
                },
              );
            }
            return buildBody((state as ProfileLoadedState).userdata);
          }.call(),
        );
      },
    );
  }

  AppBar buildAppBar({bool showEdit = true}) {
    return AppBar(
      title: Text(R.string.moreScreen.profile).tr(),
      actions: !showEdit
          ? null
          : [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: IconButton(
                  onPressed: () {},
                  icon: FSImage.asset(imageResource: R.image.vector.editOutlined),
                ),
              ),
            ],
    );
  }

  Widget buildLoading() {
    return const Center(
      child: FSProgressIndicator(),
    );
  }

  Widget buildBody(UserModel userdata) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        ProfileHeader(
          banner: userdata.banner != null
              ? FSImage.network(
                  imageUrl: userdata.banner!,
                  fit: BoxFit.cover,
                )
              : FSImage.asset(
                  imageResource: R.image.vector.placeHolder,
                  fit: BoxFit.cover,
                ),
          avatar: userdata.avatar != null
              ? FSImage.network(
                  imageUrl: userdata.avatar!,
                  fit: BoxFit.cover,
                )
              : FSImage.asset(
                  imageResource: R.image.vector.placeHolder,
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(height: 16),
        Text(
          userdata.name ?? userdata.userId,
          style: context.titleL.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Divider(),
        ),
        if (userdata.roles.contains('supplier'))
          ListTile(
            title:  Text(R.string.moreScreen.supplierInfo.tr()),
            leading: const Icon(Icons.person),
            onTap: () {
              getRepo<SupplierRepository>().getSupplier().then((value) {
                context.pushNamed(routes.supplierInfo, pathParameters: {
                  'id': value.id,
                });
              });
            },
          ),
        ListTile(
          title: Text(R.string.moreScreen.signOut).tr(),
          leading: const Icon(Icons.logout),
          onTap: () async {
            final token = await FirebaseMessaging.instance.getToken();
            if (token != null) {
              await getRepo<AuthenticationRepository>().unregisterFCM(token);
            }
            FirebaseAuth.instance.signOut().whenComplete(
              () {
                context.goNamed(routes.root);
              },
            );
          },
        ),
      ],
    );
  }
}
