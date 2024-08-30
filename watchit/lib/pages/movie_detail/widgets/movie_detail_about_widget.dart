import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:watchit/data/models/movie.dart';

class MovieDetailAboutWidget extends StatelessWidget {
  const MovieDetailAboutWidget({super.key, required this.movie, });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: _buildIcon(Icons.calendar_today_outlined),
                ),
                Text('Ano: ${movie.year}'),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                  child: _buildIcon(Icons.timer_outlined),
                ),
                Text(
                  prettyDuration(
                    Duration(minutes: movie.duration),
                    abbreviated: true,
                    delimiter: " ",
                    spacer: "",
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                  child: _buildIcon(Icons.category),
                ),
                Text(movie.gender),
              ],
            ),
            const SizedBox(height: 16.0,),
            Text(
              "Sinopse",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              movie.description,
              style: Theme.of(context).textTheme.labelMedium,
            )
          ],  
        ),
      ),
    );
  }

  Icon _buildIcon(IconData iconData) => Icon(iconData, color: Colors.amber, size: 16.0,);
}