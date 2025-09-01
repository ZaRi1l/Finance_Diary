import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


AppOpenAd? appOpenAd;
RewardedAd? rewardedAd;


const bannerAdId = kReleaseMode ? "ca-app-pub-5245737851255543/6862144672" : 'ca-app-pub-3940256099942544/6300978111';    // 내거 : 테스트용
const openAdId = kReleaseMode ? "ca-app-pub-5245737851255543/8472811061" : "ca-app-pub-3940256099942544/3419835294";
const rewardAdId = kReleaseMode ? "ca-app-pub-5245737851255543/4473608887" : "ca-app-pub-3940256099942544/5224354917";


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
        },),);
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