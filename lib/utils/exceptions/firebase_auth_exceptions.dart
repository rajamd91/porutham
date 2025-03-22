///Custom exception class to handle various Firebase Authentication related errors.
class TFirebaseAuthException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code
  TFirebaseAuthException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The mail address is already registered.please use a different mail';
      case 'invalid-email':
        return 'The Email provided is invalid.Please enter a valid Email';
      case 'weak-password':
        return 'Please enter a strong password.';
      case 'user-disabled':
        return 'This user has been disabled.Please contact support for help.';
      case 'user-not-found':
        return 'Invalid details,user not found.';
      case 'wrong-password':
        return 'Incorrect password,please try again.';
      case 'invalid-verification-code':
        return 'Invalid verification code.Please enter valid code';
      case 'invalid-verification-id':
        return 'Invalid verification ID.Please request a new verification code';
      case 'quota-exceeded':
        return 'Quota exceeded.Please try again later';
      case 'email-already-exists':
        return 'The mail entered already exist.please enter different code';
      case 'provider-already-linked':
        return 'The account is already linked with another provider';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication.please login again.';
      case 'credential-already-in-use':
        return 'The credential already associated with different user account';
      case 'user-mismatch':
        return 'The supplied credentials do not correspond to the previously signed in user';
      case 'account-exist-with-different-credential':
        return 'An account already exist with same email,but with different sign in credentials';
      // return const TExceptions(
      //     'Too many requests,Service Temporarily blocked.');
      case 'invalid-argument':
        return 'An invalid argument was provided to an Authentication method.';
      case 'invalid-password':
        return 'Incorrect password,please try again.';
      case 'invalid-phone-number':
        return 'The provider phone number is invalid.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.Contact support for assistance.';
      case 'session-cookie-expired':
        return 'The provided Firebase session cookie is expired .';
      case 'uid-already-exists':
        return 'The provided uid is already in use by an existing user.';
      default:
        return 'Unexpected Firebase Error occurred.Please try again.';
    }
  }
}

//   const TExceptions([this.message = 'An unknown exception occurred']);
//
//   /// Create an authentication message
//   /// from a firebase authentication exception code.
//   factory TExceptions.fromCode(String code) {
//     switch (code) {
//       case 'email-already-in-use':
//         return const TExceptions('Email already exists');
//       case 'invalid-email':
//         return const TExceptions('Email is not valid or badly formatted.');
//       case 'weak-password':
//         return const TExceptions('Please enter a strong password.');
//       case 'user-disabled':
//         return const TExceptions(
//             'This user has been disabled.Please contact support for help.');
//       case 'user-not-found':
//         return const TExceptions('Invalid details,please create an account.');
//       case 'wrong-password':
//         return const TExceptions('Incorrect password,please try again.');
//       case 'too-many-requests':
//         return const TExceptions(
//             'Too many requests,Service Temporarily blocked.');
//       case 'invalid-argument':
//         return const TExceptions(
//             'An invalid argument was provided to an Authentication method.');
//       case 'invalid-password':
//         return const TExceptions('Incorrect password,please try again.');
//       case 'invalid-phone-number':
//         return const TExceptions('The provider phone number is invalid.');
//       case 'operation-not-allowed':
//         return const TExceptions(
//             'The provided sign-in provider is disabled for your Firebase project.');
//       case 'session-cookie-expired':
//         return const TExceptions(
//             'The provided Firebase session cookie is expired .');
//       case 'uid-already-exists':
//         return const TExceptions(
//             'The provided uid is already in use by an existing user.');
//       default:
//         return const TExceptions();
//     }
//   }
// }
