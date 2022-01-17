import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : '';

  BannerAdListener get adListner => _adListner;

  BannerAdListener _adListner = BannerAdListener(
    onAdLoaded: (ad) => print('Ad Loaded: ${ad.adUnitId}'),
    onAdClosed: (ad) => print('Ad Closed: ${ad.adUnitId}'),
    onAdFailedToLoad: (ad, error) =>
        print('Ad failed to Load: ${ad.adUnitId}, $error'),
    onAdOpened: (ad) => print('Ad Opened: ${ad.adUnitId}'),
    onAdImpression: (ad) => print('Ad impression: ${ad.adUnitId}'),
    onAdWillDismissScreen: (ad) => print('App Exit: ${ad.adUnitId}'),
  );
}
