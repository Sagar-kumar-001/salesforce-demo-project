public class JWTAuthService {

    public static void getAccessToken() {
        // ========= CONFIG =========
        String username        = 'tarun.sharma@cloudanalogy.com'; // integration user
        String consumerKey     = '3MVG9pRzvMkjMb6m34IWmDw9GFhLEsvCAb3P5VL4LxzMR0fWwLvwC8E_t39gEP0YjYHfvpBug4rQMY8oAYglg';
        String audience        = 'https://login.salesforce.com'; // prod/dev-ed
        String tokenEndpoint   = 'https://login.salesforce.com/services/oauth2/token';
        String certName        = 'tarunorgcertificate'; // Certificate API name
        String apiEndpoint     = 'https://cloudanalogycom399-dev-ed.my.salesforce.com/services/data/v48.0/sobjects/Account/';

        // ========= JWT CREATION =========
        Auth.JWT jwt = new Auth.JWT();
        jwt.setSub(username);
        jwt.setIss(consumerKey);
        jwt.setAud(audience);

        // REQUIRED exp claim (UNIX seconds, max +5 min)
        Long exp = (System.currentTimeMillis() / 1000) + 300;

        Map<String, Object> claims = new Map<String, Object>();
        claims.put('exp', exp);
        jwt.setAdditionalClaims(claims);

        // ========= SIGN JWT =========
        Auth.JWS jws = new Auth.JWS(jwt, certName);

        // (Optional) Debug JWT
        System.debug('JWT Token --> ' + jws.getCompactSerialization());

        // ========= EXCHANGE JWT FOR ACCESS TOKEN =========
        Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(tokenEndpoint, jws);

        String accessToken = bearer.getAccessToken();
        System.debug('Access Token --> ' + accessToken);

        // ========= CALL SALESFORCE REST API =========
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(apiEndpoint);
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        request.setHeader('Content-Type', 'application/json');

        HttpResponse response = http.send(request);

        System.debug('Status Code --> ' + response.getStatusCode());
        System.debug('Response --> ' + response.getBody());
    }
}