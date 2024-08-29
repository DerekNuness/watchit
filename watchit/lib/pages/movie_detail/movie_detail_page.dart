import 'package:flutter/material.dart';
import 'package:watchit/data/models/movie.dart';
import 'package:watchit/pages/movie_detail/movie_datail_controller.dart';
import 'package:watchit/pages/movie_detail/widgets/movie_detail_cover_widget.dart';
import 'package:watchit/pages/movie_list/movie_list_controller.dart';
import 'package:watchit/pages/movie_list/widgets/movie_item_widget.dart';
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
              MovieDetailCoverWidget(movie: movie,)
            ],
          );
        },
      )
    );
  }
}