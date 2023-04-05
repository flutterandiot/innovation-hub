// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:innovation_hub/app/model/idea_model.dart';
import 'package:innovation_hub/app/provider/idea_controller.dart';

class IdeaDetailsPage extends HookConsumerWidget {
  const IdeaDetailsPage({
    super.key,
    required this.goFromPage,
  });

  /// Record the page call this page
  final String goFromPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idea = ref.watch(ideaManageProvider)!;
    final nameTextController = useTextEditingController(text: idea.name);
    // final desccriptionTextController = useTextEditingController(text: idea.description);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Idea page'),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              _saveIdeaName(ref, idea);
              context.go(goFromPage);
              // context.goNamed(AppRoute.projectDashboard.name, params: {
              //   'id': ref.read(activeProjectProvider).id,
              // });
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 32),
              child: Column(
                children: [
                  Text(idea.concept),
                  const SizedBox(height: 12),
                  TextField(
                    controller: nameTextController,
                    decoration: const InputDecoration(
                      hintText: 'Idea name',
                      labelText: 'Name',
                    ),
                    onSubmitted: (value) {
                      idea.name = nameTextController.text;
                      // _saveIdeaName(ref, idea);
                    },
                  ),
                  // const SizedBox(height: 12),
                  // TextField(
                  //   controller: nameTextController,
                  //   decoration: const InputDecoration(
                  //     hintText: 'description of idea',
                  //     labelText: 'Description',
                  //   ),
                  // ),
                  const SizedBox(height: 12),
                  const Text('Rating idea'),
                  const _RatingIdea(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveIdeaName(WidgetRef ref, Idea idea) {
    ref.read(ideaManageProvider.notifier).update(idea);
  }
}

class _RatingIdea extends ConsumerWidget {
  const _RatingIdea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idea = ref.watch(ideaManageProvider);
    return RatingBar.builder(
      initialRating: idea!.rating.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        ref.read(ideaManageProvider.notifier).ratingIdea(idea, rating);
      },
    );
  }
}
