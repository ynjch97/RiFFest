import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// todo: 현재 미사용임
class FestivalPoster extends ConsumerWidget {
  const FestivalPoster({
    super.key,
  });

  Future<void> _onPosterTap(WidgetRef ref) async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 200,
      maxWidth: 150,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _onPosterTap(ref),
      child: SizedBox(
        width: 150,
        height: 200,
        child: FadeInImage.assetNetwork(
          placeholder: "assets/images/kelly.png",
          image:
              "https://ticketimage.interpark.com/Play/image/large/24/24005722_p.gif",
        ),
      ),
    );
  }
}
