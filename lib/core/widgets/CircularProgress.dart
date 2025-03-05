import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: const CardLoading(
        height: 160,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        margin: EdgeInsets.only(bottom: 10),
      ),
    );
  }
}