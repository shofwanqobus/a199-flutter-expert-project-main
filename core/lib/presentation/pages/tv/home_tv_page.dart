import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/presentation/bloc/tv/now_playing_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTVPage extends StatefulWidget {
  const HomeTVPage({Key? key}) : super(key: key);

  @override
  _HomeTVPage createState() => _HomeTVPage();
}

class _HomeTVPage extends State<HomeTVPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Now Playing TV', style: kHeading6),
        ),
        BlocBuilder<NowPlayingTVBloc, NowPlayingTVState>(
          builder: (_, state) {
            if (state is NowPlayingTVLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NowPlayingTVData) {
              return TVList(state.tv);
            } else {
              return const Text('Failed');
            }
          },
        ),
        _buildSubHeading(
            title: 'Popular TV',
            onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE)),
        BlocBuilder<PopularTVBloc, PopularTVState>(
          builder: (_, state) {
            if (state is PopularTVLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PopularTVData) {
              return TVList(state.tv);
            } else {
              return const Text('Failed');
            }
          },
        ),
        _buildSubHeading(
            title: 'Top Rated TV',
            onTap: () => Navigator.pushNamed(context, TOP_RATED_ROUTE)),
        BlocBuilder<TopRatedTVBloc, TopRatedTVState>(
          builder: (_, state) {
            if (state is TopRatedTVLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TopRatedTVData) {
              return TVList(state.tv);
            } else {
              return const Text('Failed');
            }
          },
        ),
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tv;

  const TVList(this.tv);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final data = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_DETAIL_ROUTE,
                  arguments: data.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${data.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
