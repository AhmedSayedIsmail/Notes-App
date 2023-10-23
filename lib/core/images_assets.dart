class ImagesAssets {
  static final ImagesAssets _instance = ImagesAssets._internal();
  factory ImagesAssets() {
    return _instance;
  }
  ImagesAssets._internal();
  Map<AssetName, String> assets = {
    AssetName.logoImage: "assets/images/logo_img.png",
    AssetName.manProfile: "assets/images/man_photo.jpeg",
    AssetName.manProfile2: "assets/images/man_photo2.jpeg",
    AssetName.womanProfile: "assets/images/woman.jpg",
    AssetName.womanProfile2: "assets/images/woman2.jpg",
    AssetName.onboardingOne: "assets/images/onboardingone.png",
    AssetName.onboardingTwo: "assets/images/onboardingtwo.png",
    AssetName.onboardingThree: "assets/images/onboardingthree.png",
    AssetName.settingImage: "assets/images/settings-concept-illustration_114360-3056.png"
  };
}

enum AssetName {
  manProfile,
  manProfile2,
  womanProfile,
  womanProfile2,
  logoImage,
  onboardingOne,
  onboardingTwo,
  onboardingThree,
  settingImage,
}
