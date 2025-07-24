enum PaymentType { cod, stripe }

String toStringFromPaymentType(PaymentType type) {
  switch (type) {
    case PaymentType.cod:
      return 'Cash on Delivery';

    case PaymentType.stripe:
      return 'Stripe Payment';
  }
}
