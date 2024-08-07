const amplifyconfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "IdentityManager": {
          "Default": {}
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "ap-southeast-2_mqUWnGcU2",
            "AppClientId": "2ntgffdtr4c8gfimn88lni3v5g",
            "Region": "ap-southeast-2"
          }
        },
        "Auth": {
          "Default": {
            "authenticationFlowType": "USER_SRP_AUTH",
            "usernameAttributes": ["email"],
            "signupAttributes": [
              "email", "name"
            ],
            "passwordProtectionSettings": {
              "passwordPolicyMinLength": 8,
              "passwordPolicyCharacters": []
            }
          }
        }
      }
    }
  }
}''';