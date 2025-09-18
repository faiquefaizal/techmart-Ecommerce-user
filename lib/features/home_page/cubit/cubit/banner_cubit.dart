import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techmart/features/home_page/features/banners/services/banner_service.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitial());

  Future<void> fetchBanners() async {
    try {
      emit(BannerLoading());

      final banners = await BannerService.getAllBaners();
      if (banners.isNotEmpty) {
        final allImages = banners.expand((e) => e).toList();
        emit(BannerLoaded(imageUrls: allImages));
      } else {
        emit(BannerError(message: "No banners found."));
      }
    } catch (e) {
      emit(BannerError(message: e.toString()));
    }
  }
}
