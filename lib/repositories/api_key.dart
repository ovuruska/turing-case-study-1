class APIKeyRepository {
  String? apiKey;

  static final APIKeyRepository instance = APIKeyRepository._();

  APIKeyRepository._();

  setKey(String apiKey) {
    this.apiKey = apiKey;
    return this;
  }

  get key => apiKey;
}
