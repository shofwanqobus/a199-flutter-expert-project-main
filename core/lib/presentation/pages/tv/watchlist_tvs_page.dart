import 'package:core/presentation/bloc/tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTVsPage extends StatefulWidget {
  const WatchlistTVsPage({Key? key}) : super(key: key);

  @override
  _WatchlistTVsPageState createState() => _WatchlistTVsPageState();
}

class _WatchlistTVsPageState extends State<WatchlistTVsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTVBloc, WatchlistTVState>(
          builder: (_, state) {
            if (state is WatchlistTVLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTVData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tv[index];
                  return TVCard(tv);
                },
                itemCount: state.tv.length,
              );
            } else if (state is WatchlistTVEmpty) {
              return const Center(child: Text('Watchlist is Empty'));
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text((state as WatchlistTVError).message),
              );
            }
          },
        ),
      ),
    );
  }
}
