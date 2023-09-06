class AuthRepository {

  

  Future<bool> isAuthorized() async {
    await Future.delayed(Duration(seconds: 5));
    return true;
  }
}
