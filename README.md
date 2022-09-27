# PKCE Generator

A CFML component to generate or verify a Proof Key for Code Exchange (PKCE) challenge pair.

## Installation

```
box install pkce
```

## Usage

### Generating a new verifier and challange pair


```
var objPKCE = new PKCE();
var stuPKCE = objPKCE.generatePKCE();
```

returns a struct containing values similar to the following:

```
{
    'code_verifier': 'a7ae977cfb1cf9b1ee053c9fafaab0250e0fc068e37d993e8128e866',
    'code_challenge': 'rZ2rN32NrlF1gfyVuvxjLZLJdDN1WxoBJhuvGV1wKgw',
    'code_challenge_method': 'S256'
}
```

### Challenge Verification

```
var isValid = objPKCE.verifyChallenge( codeVerifier, codeChallenge );
```



---

MIT License

Copyright (c) 2022 Matt Gifford (coldfumonkeh)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.