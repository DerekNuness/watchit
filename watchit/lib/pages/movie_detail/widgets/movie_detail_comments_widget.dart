import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart'as timeago;
import 'package:watchit/data/models/movie.dart';
import 'package:watchit/pages/movie_detail/movie_datail_controller.dart';
import 'package:watchit/pages/movie_detail/widgets/delete_comment_widget.dart';
import 'package:watchit/service_locator.dart';

class MovieDetailCommentsWidget extends StatelessWidget {
  MovieDetailCommentsWidget({super.key, required this.movie});

  final controller = getIt<MovieDetailController>();
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: movie.comments.length,
      itemBuilder: (context, index) {
        var comment = movie.comments[index];

        return ListTile(
          title: Text(
            comment.comment,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          subtitle: Row(
            children: [
              Text(timeago.format(comment.createdAt)),
              const SizedBox(width: 16.0,),
              const Text("•"),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder:(context) => DeleteCommentWidget(
                      onDeleted: () async => controller.deleteComment(comment.id)
                    ),
                  );
                }, 
                style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                child: const Text("Excluir")
              )
            ],
          ),
        );
      }
    );
  }
}