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
                RatingBar.builder(
                  initialRating: 3,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return const Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.red,
                        );
                      case 1:
                        return const Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return const Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return const Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                      default:
                        return const Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                    }
                  },
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
