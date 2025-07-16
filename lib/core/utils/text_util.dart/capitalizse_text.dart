String captilize(String? name) {
  if (name == null || name.isEmpty) return "loading..";
  return name[0].toUpperCase() + name.substring(1);
}
