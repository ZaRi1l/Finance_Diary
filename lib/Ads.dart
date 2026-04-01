import 'package:google_mobile_ads/google_mobile_ads.dart';


AppOpenAd? appOpenAd;
RewardedAd? rewardedAd;


const bannerAdId = 'ca-app-pub-3940256099942544/6300978111';
const openAdId = "ca-app-pub-3940256099942544/3419835294";
const rewardAdId = "ca-app-pub-3940256099942544/5224354917";


loadAppOpenAd() {
  AppOpenAd.load(
      adUnitId: openAdId,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("error 남");
          print(error);
        },),
      orientation: AppOpenAd.orientationPortrait);
}


void loadRewardFullBanner() async {
  await RewardedAd.load(
    adUnitId: rewardAdId, // 보상형 동영상 광고 인듯
    request: const AdRequest(),
    rewardedAdLoadCallback: RewardedAdLoadCallback(
      onAdLoaded: (RewardedAd ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (RewardedAd ad) {
            ad.dispose();
          },
          onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
            ad.dispose();
          },
        );
        rewardedAd = ad;
      },
      onAdFailedToLoad: (LoadAdError error) {
        print("-------------------애러");
      },
    ),
  );
}