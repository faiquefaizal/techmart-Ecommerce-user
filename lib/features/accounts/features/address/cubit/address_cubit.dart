// import 'dart:async';
// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:techmart/features/accounts/features/address/models/address_model.dart';
// import 'package:techmart/features/accounts/presentation/screens/address_screen.dart';
// import 'package:techmart/features/accounts/service/address_service.dart';
// import 'package:techmart/features/cart/cubit/cart_cubit.dart';

// part 'address_state.dart';

// class AddressCubit extends Cubit<AddressState> {
//   StreamSubscription? _streamSubscription;
//   AddressCubit() : super(AddressInitial());
//   void fetchAddress() {
//     emit(AddressLoading());
//     _streamSubscription?.cancel();
//     _streamSubscription = AddressService.getAllAddress().listen(
//       (address) {
//         if (address.isEmpty) {
//           emit(AddressIsEmpty());
//         } else {
//           emit(AddressLoaded(addressList: address));
//         }
//       },
//       onError: (error) {
//         emit(AddressError(error: error.toString()));
//       },
//     );
//   }

//   void onAddAddress(AddressModel addressModel) async {
//     try {
//       await AddressService.addAddress(addressModel);
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   void updateAddress(AddressModel addressModel) async {
//     try {
//       await AddressService.editAddress(addressModel);
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   void deleteAddress(AddressModel addressModel) async {
//     try {
//       await AddressService.delete(addressModel.id!);
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   @override
//   Future<void> close() {
//     _streamSubscription?.cancel();
//     return super.close();
//   }
// }
