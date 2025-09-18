//   import 'package:stripe_js/stripe_js.dart';
// import 'package:techmart/features/payments/const/payment.dart';

// import 'package:stripe_js/stripe_js.dart';

// Future<String> _paymentWebOnly(int amount) async {
//   try {
//     // call your backend to create a PaymentIntent or Checkout Session
//     final sessionId = await createWebPaymentSession(amount); // implement this on backend

//     final stripe = Stripe(publishableKey); // from your payment.dart file
//     await stripe.redirectToCheckout(sessionId: sessionId);

//     return sessionId; // or something else meaningful
//   } catch (e) {
//     log("Web payment failed: $e");
//     rethrow;
//   }
// }
