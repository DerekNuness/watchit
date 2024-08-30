import 'package:flutter/material.dart';
import 'package:watchit/data/models/movie.dart';
import 'package:watchit/pages/movie_detail/movie_datail_controller.dart';
import 'package:watchit/pages/movie_detail/widgets/add_comment_widget.dart';
import 'package:watchit/pages/movie_detail/widgets/movie_detail_about_widget.dart';
import 'package:watchit/pages/movie_detail/widgets/movie_detail_comments_widget.dart';
import 'package:watchit/pages/movie_detail/widgets/movie_detail_cover_widget.dart';
import 'package:watchit/service_locator.dart';
import 'package:watchit/widgets/progress_indicator_widget.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final controller = getIt.registerSingleton(MovieDetailController());

  @override
  void initState() {
    controller.init(widget.movie);
    super.initState();
  }

  @override
  void dispose() {
    getIt.unregister(instance: controller);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.alphaBlend(Colors.black12, Theme.of(context).scaffoldBackgroundColor),
      body: StreamBuilder<Movie>(
        initialData: widget.movie,
        stream: controller.stream,
        builder: (context, snapshot) {
          var movie = snapshot.data!;

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return ProgressIndicatorWidget();
          // }


          return CustomScrollView(
            slivers: [
              MovieDetailCoverWidget(movie: movie,),
              MovieDetailAboutWidget(movie: movie),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0,),
                  child: Text(
                    "Comentários",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              if(snapshot.connectionState == ConnectionState.waiting)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: ProgressIndicatorWidget(),
                  ),
                )
              else if(movie.comments.isEmpty) 
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Seja o primeiro a comentar",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                )
              else MovieDetailCommentsWidget(movie: movie),
              const AddCommentWidget()
            ],
          );
        },
      )
    );
  }
}