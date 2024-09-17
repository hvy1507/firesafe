
import 'package:firesafe_vnex/app/news/detail/news.detail.cubit.dart';
import 'package:firesafe_vnex/app/news/detail/news.details.state.dart';
import 'package:firesafe_vnex/components/widgets/error_widget.dart';
import 'package:firesafe_vnex/components/widgets/image.dart';
import 'package:firesafe_vnex/components/widgets/progress_indicator.dart';
import 'package:firesafe_vnex/components/widgets/text.dart';
import 'package:firesafe_vnex/utils/extensions/list.ext.dart';
import 'package:firesafe_vnex/utils/extensions/state.ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocBuilder<NewsDetailCubit, NewsDetailState>(
        builder: (BuildContext context, NewsDetailState state) {
          if (state is NewsDetailError) {
            return FSErrorWidget(retry: () async {
              await getCubit<NewsDetailCubit>().getNewsDetail();
            },);
          }
          if (state is NewsDetailLoading) {
            return const FSProgressIndicator(
              size: 60,
            );
          } else {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AspectRatio(
                  aspectRatio: 5 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: FSImage.network(
                      imageUrl: (state as NewsDetailSuccess).result.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  state.result.title,
                  style: context.headlineM.copyWith(fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                ),
                Html(data: state.result.content,onLinkTap: (value , map , element){

                })
              ].addBetween(
                const SizedBox(
                  height: 20,
                ),
              ),
            );
          }
        },
      ),
    );
  }

 AppBar buildAppBar() => AppBar(
   actions: [
     IconButton(
         onPressed: () {},
         icon: const Icon(
           Icons.more_vert,
           color: Colors.black,
         )),
     IconButton(
         onPressed: () {},
         icon: const Icon(
           Icons.share,
           color: Colors.black,
         )),
     IconButton(
         onPressed: () {},
         icon: const Icon(
           Icons.bookmark_border,
           color: Colors.black,
         )),
   ],
 );
}
