import 'package:flutter/widgets.dart';
import 'package:innovation_hub/app/project/model/project_models.dart';
import 'package:innovation_hub/app/shared/user.dart';
import 'package:innovation_hub/utils/app_utils.dart';
import 'package:test/test.dart';

void main() {
  test('Test Project Model', () {
    final project = Project(
      id: UniqueKey().toString().replaceAll('#', '').replaceAll('[', '').replaceAll(']', ''),
      name: 'Test Project',
      description: 'This for testing',
      type: ProjectType.product.name,
      components: [],
      createdAt: (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
      createdBy: User.dummyUser,
      team: [
        User.dummyUser,
      ],
      favorite: false,
    );

    print(project.toString());
  });

  test('Test Datetime Utilities', () {
    final epoch = AppUtilities.getTimeStampFromNow();

    final dateTime = AppUtilities.getTimeFromEpoch(int.tryParse(epoch) ?? 1234);

    print('Epoch: $epoch');

    print('Date time: $dateTime');

    final formatedDate = AppUtilities.getDateTimeFormatted(dateTime);
    print(formatedDate);
  });
}
