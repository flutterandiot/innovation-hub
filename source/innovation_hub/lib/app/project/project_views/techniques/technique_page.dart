// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:innovation_hub/app/model/idea_model.dart';
import 'package:innovation_hub/app/project/widgets/project_app_bar.dart';

import 'sit_attribute_dependency.dart';
import 'sit_division.dart';
import 'sit_multiplication.dart';
import 'sit_substractiion.dart';
import 'sit_task_unification.dart';

class TechniquePage extends StatelessWidget {
  const TechniquePage({
    Key? key,
    required this.technique,
  }) : super(key: key);
  final SITTechniques technique;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: ProjectPageAppBar(
          title: Text(
            'Apply SIT Technique',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: _getBodyView(),
    );
  }

  Widget _getBodyView() {
    switch (technique) {
      case SITTechniques.taskUnification:
        return const SITTaskUnification();
      case SITTechniques.substraction:
        return const SITSubstraction();
      case SITTechniques.multiplication:
        return const SITMultiplication();
      case SITTechniques.division:
        return const SITDivision();
      case SITTechniques.attributeDependency:
        return const SITAttributeDependency();
      default:
        return const SITTaskUnification();
    }
  }
}
