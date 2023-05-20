import 'package:hive/hive.dart';
import 'package:my_grocery/model/ad_banner.dart';

class LocalAdBannerService {
  late Box<AdBanner> _adBannerBox;

  Future<void> init() async {
    _adBannerBox = await Hive.openBox<AdBanner>('ADBanners');
  }

  Future<void> assignAllAdBanners({required List<AdBanner> adBanners}) async {
    await _adBannerBox.clear();
    await _adBannerBox.addAll(adBanners);
  }

  List<AdBanner> getAllAdBanners() => _adBannerBox.values.toList();
}
