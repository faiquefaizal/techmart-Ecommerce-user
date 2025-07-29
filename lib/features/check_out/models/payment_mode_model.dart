enum PaymentMode { cod, razerPay }

String toString(PaymentMode current) {
  switch (current) {
    case PaymentMode.cod:
      return "Cash on Delivery";

    case PaymentMode.razerPay:
      return "Razor Pay";
  }
}
