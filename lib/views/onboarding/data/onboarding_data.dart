import '../../../core/constants/app_images.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppImages.onboarding3,
      headline: 'study effortlessly',
      description:
          'Our online classes make you learning easy .',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding1,
      headline: 'Recorded & live classes',
      description:
          'Our online classes make you learning easy.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding2,
      headline: 'Discounts and Offers',
      description:
          'Get offers and discounts .',
    ),
  ];
}
