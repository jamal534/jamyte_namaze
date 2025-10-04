import 'package:get/get.dart';

import '../../../../core/utils/asset_path.dart';

class SlideModel {
  final String imageUrl;
  final String title;
  final String description;

  SlideModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slidList = [
  SlideModel(
    imageUrl: AssetPath.onboarding1,
    title: 'Welcome to Prayer Connect',
    description:
    "Join and coordinate prayers with fellow Muslims near you.",
  ),
  SlideModel(
    imageUrl: AssetPath.onboarding2,
    title: """حَدَّثَنَا عَبْدُ اللَّهِ بْنُ يُوسُفَ، قَالَ أَخْبَرَنَا مَالِكٌ، عَنْ نَافِعٍ، عَنْ عَبْدِ اللَّهِ بْنِ عُمَرَ، أَنَّ رَسُولَ اللهِ قَالَ " صَلَاةُ الْجَمَاعَةِ تَفْضُلُ صَلَاةَ الْقَذَ بِسَبْعٍ وَعِشْرِينَ دَرَجَةً""",
    description: "",
  ),
  SlideModel(
    imageUrl: AssetPath.onboarding3,
    title: "Connecting people for (Congregational Prayer) Salat Jama'ah ",
    description: "Set your prayer times and never miss a prayer!",
  ),
];
