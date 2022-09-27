/**
* @displayname pkce
* @output false
* @hint The pkce object.
* @author Matt Gifford
* @website https://www.monkehworks.com
* @purpose A CFML component to manage generation of PKCE values for the OAuth2 protocol.
**/
component accessors=true {

    public pkce function init(){
        return this;
    }

	/**
	 * Generates a struct containing the code verifier and code challenger values
	 */
	public struct function generatePKCE(){
		var code_verifier = generatePKCECodeVerifier();
		return {
			'code_verifier': code_verifier,
			'code_challenge': generatePKCECodeChallenge( code_verifier ),
			'code_challenge_method': 'S256'
		};
	}

	/**
	 * Verify a challenge (can be used by an OAuth 2.0 server to verify)
	 *
	 * @codeVerifier The code verifier to use when verifying the code challenge
	 * @codeChallenge The code challenge to use when verifying
	 */
	public boolean function verifyChallenge(
		required string codeVerifier,
		required string codeChallenge
	){
		var genChallenge = generatePKCECodeChallenge( arguments.codeVerifier );
		return ( arguments.codeChallenge == genChallenge );
	}

	/**
	 * Generate a code verifier
	 */
	public string function generatePKCECodeVerifier(){
		var base64Encoder = createObject("java", "java.util.Base64").getUrlEncoder().withoutPadding();
		var secureRandom  = createObject("java", "java.security.SecureRandom").getInstanceStrong();
		var codeVerifier = repeatString("*", 32).getBytes();
		secureRandom.nextBytes(codeVerifier);
		return base64Encoder.encodeToString(codeVerifier);
	}

    /**
	 * Generate a code challenge from the given code verifier
	 *
	 * @codeVerifier The code verifier to use when generating the code challenge
	 */
	public string function generatePKCECodeChallenge( required string codeVerifier ){
		var base64Encoder = createObject("java", "java.util.Base64").getUrlEncoder().withoutPadding();
		var base64 = createObject("java", "java.util.Base64");
		var messageDigest=createObject('java','java.security.MessageDigest').getInstance("SHA-256");
		messageDigest.update(arguments.codeVerifier.getBytes("UTF-8"));
		return base64Encoder.encodeToString(messageDigest.digest());
	}

}