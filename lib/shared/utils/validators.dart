var regex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class Validators {
  static String? validateEmail(String? email) {
    if(email!.isEmpty) {
      return "Enter your email address";
    } else if (!regex.hasMatch(email)) {
      return 'invalid email address';
    } else {
      return null;
    }
  }

  static String? validatePin(String? pin) {
    if (pin!.isEmpty) {
      return 'Input your pin';
    } else if (pin.length < 6) {
      return 'Pin should be more than digits';
    } else {
      return null;
    }
  }

  static String? validateField(String? value) {
    if (value!.isEmpty) {
      return 'Field cannot be empty';
    } else {
      return null;
    }
  }

  static String? validateFullName(String? value) {
    if (value!.isEmpty) {
      return 'Field cannot be empty';
    } else if(value.split(" ").length < 2) {
      return 'Enter a first and last name';
    } else {
      return null;
    }
  }

  static String? validateBVN(String? value) {
    if (value!.length < 11) {
      return 'Enter a valid BVN number';
    } else {
      return null;
    }
  }

  static String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return 'Phone number is required';
    } else if (value.length < 11) {
      return "Invalid phone number (phone must contain 11 digits)";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password) {
    if(password!.isEmpty) {
      return "Enter your password";
    } else if (password.length < 8) {
      return 'Password must have at least 8 characters';
    } else {
      return null;
    }
  }

  static String? validateAccountNumber(String? number) {
    if(number!.isEmpty) {
      return "You must enter an account number";
    } else if (number.length < 10) {
      return 'Invalid account number';
    } else {
      return null;
    }
  }
}