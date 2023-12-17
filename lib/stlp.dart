library stlp;


import 'package:flutter/material.dart';

abstract class StatelessWidgetPlus extends StatelessWidget {
  StatelessWidgetPlus({Key? key}) : super(key: key);

  final _GlobalWidget _globalWidget = _GlobalWidget();

  @override
  Widget build(BuildContext context) {
    return _globalWidget.ob(() => buildPlus(context));
  }
  
  void reload() {
    _globalWidget.setState(() {});
  }

  @protected
  Widget buildPlus(BuildContext context);
}



class _GlobalWidget {
  final GlobalKey<_ConsumerState> _key = GlobalKey<_ConsumerState>();

  Widget ob(Widget Function() lamda) {
    return _Consumer(
      key: _key,
      child: lamda,
    );
  }
  void setState(void Function() fn) => _key.currentState?.setState(fn);

}



class _Consumer extends StatefulWidget {
  _Consumer({super.key, required this.child});
  Widget Function() child;

  @override
  State<_Consumer> createState() => _ConsumerState();
}

class _ConsumerState extends State<_Consumer> {
  @override
  Widget build(BuildContext context) {
    return widget.child();
  }
}

