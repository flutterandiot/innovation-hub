import 'package:easy_stepper/easy_stepper.dart';

class TagView extends StatelessWidget {
  const TagView({
    Key? key,
    required this.tag,
    required this.onTagSelect,
    required this.onTagDelete,
  }) : super(key: key);

  final String tag;
  final Function(String) onTagSelect;
  final Function(String) onTagDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        color: const Color.fromARGB(255, 252, 0, 143),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(20.0),
        //   ),
        // ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        child: InkWell(
          onTap: () {
            debugPrint('Selected: #$tag');
            onTagSelect(tag);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tag,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 4.0),
                InkWell(
                  child: const Icon(
                    Icons.cancel,
                    size: 14.0,
                    color: Color.fromARGB(255, 233, 233, 233),
                  ),
                  onTap: () {
                    onTagDelete(tag);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
