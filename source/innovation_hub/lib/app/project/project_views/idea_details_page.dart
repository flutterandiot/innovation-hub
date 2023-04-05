import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:innovation_hub/app/provider/idea_controller.dart';

class IdeaDetailsPage extends HookConsumerWidget {
  const IdeaDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idea = ref.watch(ideaManageProvider)!;

    final nameTextController = useTextEditingController(text: idea.name);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Idea page'),
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
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nameTextController,
                  decoration: const InputDecoration(
                    hintText: 'description of idea',
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Rating idea'),
                const _RatingIdea(),
              ],
            ),
          ),
        ),
      ),
    );
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
        print(rating);
        ref.read(ideaManageProvider.notifier).ratingIdea(idea, rating);
      },
    );
  }
}
