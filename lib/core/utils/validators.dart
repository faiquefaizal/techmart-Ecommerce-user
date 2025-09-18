class Validators {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? dob(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your date of birth";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
  }

  static String? gender(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select gender";
    }
    return null;
  }

  static String? state(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "State is required";
    }
    return null;
  }

  static String? city(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "City is required";
    }
    return null;
  }

  static String? area(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Area is required";
    }
    return null;
  }

  static String? houseNo(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "House No. is required";
    }
    return null;
  }

  static String? pinCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Pin code is required";
    }
    if (!RegExp(r'^[0-9]{6}$').hasMatch(value.trim())) {
      return "Enter a valid 6-digit pin code";
    }
    return null;
  }
}
