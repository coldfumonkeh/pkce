component extends="testbox.system.BaseSpec"{

	function beforeAll(){
		variables.objPKCE = createMock( 'PKCE' ).init();
	}

	function afterAll(){}

	function run(){

		describe( "The PKCE Component", function(){

			describe( "Instance of the PKCE Component", function(){

				it( 'should be the correct return type', function(){
					expect( variables.objPKCE )
						.toBeTypeOf( 'component' )
						.toBeInstanceOf( 'PKCE' );
				} );

				it( 'should have the following methods', function(){

					expect( variables.objPKCE )
						.toHaveKey( 'generatePKCE' )
						.toHaveKey( 'generatePKCECodeVerifier' )
						.toHaveKey( 'generatePKCECodeChallenge' );

				} );

			} );

		});

		describe( "Calling Methods", function(){

			describe( 'The `generatePKCE()` method', function(){

				it( 'should return the expected structure', function(){

					var mockService = createMock( 'PKCE' );
					mockService.$( method = 'generatePKCECodeVerifier', returns = 'verifier' );
					mockService.$( method = 'generatePKCECodeChallenge', returns = 'challenge' );

					var resp = mockService.generatePKCE();

					expect( resp )
						.toBeStruct()
						.toHaveKey( 'code_verifier' )
						.toHaveKey( 'code_challenge' )
						.toHaveKey( 'code_challenge_method' );

					expect( mockService.$count( 'generatePKCECodeVerifier' ) ).toBe( 1 );
					expect( mockService.$count( 'generatePKCECodeChallenge' ) ).toBe( 1 );

				} );

			} );

			describe( 'The `generatePKCECodeVerifier()` method', function(){

				it( 'should return a string', function(){

					var resp = variables.objPKCE.generatePKCECodeVerifier();

					expect( resp )
						.toBeString();

				} );

			} );

			describe( 'The `generatePKCECodeChallenge()` method', function(){

				it( 'should return a hashed string', function(){

					var codeVerifier = 'a7ae977cfb1cf9b1ee053c9fafaab0250e0fc068e37d993e8128e866';
					var resp = variables.objPKCE.generatePKCECodeChallenge( codeVerifier );

					expect( resp )
						.toBeString()
						.toBe( 'rZ2rN32NrlF1gfyVuvxjLZLJdDN1WxoBJhuvGV1wKgw' );

				} );

			} );

			describe( 'The `verifyChallenge()` method', function(){

				it( 'should return a boolean', function(){

					var codeVerifier = 'a7ae977cfb1cf9b1ee053c9fafaab0250e0fc068e37d993e8128e866';
					var codeChallenge = 'rZ2rN32NrlF1gfyVuvxjLZLJdDN1WxoBJhuvGV1wKgw';
					var resp = variables.objPKCE.verifyChallenge( codeVerifier, codeChallenge );

					expect( resp )
						.toBeBoolean()
						.toBeTrue();

					var codeVerifier = 'abcdefghijk';
					var codeChallenge = 'rZ2rN32NrlF1gfyVuvxjLZLJdDN1WxoBJhuvGV1wKgw';
					var resp = variables.objPKCE.verifyChallenge( codeVerifier, codeChallenge );

					expect( resp )
						.toBeBoolean()
						.toBeFalse();

				} );

			} );

		} );


	}

}
