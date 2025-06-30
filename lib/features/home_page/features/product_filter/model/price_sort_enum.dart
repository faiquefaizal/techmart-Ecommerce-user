enum PriceSort { lowToHigh, highToLow }

String getPrice(PriceSort price) {
  switch (price) {
    case PriceSort.lowToHigh:
      return "Price : Low to High";

    case PriceSort.highToLow:
      return "Price : High to Low";
  }
}
