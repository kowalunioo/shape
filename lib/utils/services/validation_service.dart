class ValidationService
{
  bool validateUsername(String usernameToValidate)
  {
    bool nameValid = usernameToValidate.isNotEmpty;
    return nameValid;
  }

  bool validateEmail(String emailToValidate) 
  {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailToValidate);
    return emailValid;
  }

  bool validatePassword(String passwordToValidate) 
  {
    bool passwordValid = RegExp(r"^(?=.*[0-9a-zA-Z]).{6,}").hasMatch(passwordToValidate);
    return passwordValid;
  }
}