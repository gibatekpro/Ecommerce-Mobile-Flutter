import 'package:flutter/material.dart';

import '../../util/util.dart';

class NavDrawerHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF009688),
              Color(0xFF00695C),
              Color(0xFF4DB6AC),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(
          16.0,
          16.0,
          16.0,
          0.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Util.logo,
              width: 48.0,
              height: 48.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Nav Header Title',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const Text(
              'Nav Header Subtitle',
            ),
          ],
        ),
      ),
    );
  }
}
