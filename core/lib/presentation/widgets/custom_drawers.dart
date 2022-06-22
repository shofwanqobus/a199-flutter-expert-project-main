import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  const CustomDrawer({required this.content, Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double slide = 255.0 * _controller.value;
          double scale = 1 - (_controller.value * 0.3);

          return Card(
            child: Stack(
              children: [
                _drawer(),
                Transform(
                    transform: Matrix4.identity()
                      ..translate(slide)
                      ..scale(scale),
                    alignment: Alignment.centerLeft,
                    child: widget.content),
              ],
            ),
          );
        },
      ),
    );
  }

  void toggle() =>
      _controller.isDismissed ? _controller.forward() : _controller.reverse();

  Widget _drawer() => Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/circle-g.png'),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.home_max),
            title: const Text('Movies & TV'),
            onTap: () {
              _controller.reverse();
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WATCHLIST_ROUTE);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ABOUT_ROUTE);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
          ListTile(
            onTap: () => throw Exception(),
            leading: const Icon(Icons.error),
            title: const Text('Throw Test Exception'),
          ),
        ],
      );
}
