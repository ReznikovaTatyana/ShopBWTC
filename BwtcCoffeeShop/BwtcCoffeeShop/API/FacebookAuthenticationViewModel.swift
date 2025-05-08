//
//  FacebookAuthenticationViewModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 24.03.2024.
//

import Foundation
import UIKit
import FacebookLogin
import FBSDKLoginKit

class FacebookAuthenticationViewModel {
    public static let shared = FacebookAuthenticationViewModel()
    private init() {}
    let loginManager = FBSDKLoginKit.LoginManager()
    
    public func facebookAuthentication(vc: UIViewController) {
        loginManager.logIn(permissions: ["public_profile", "email"], from: vc) { (result, error) in
            if let error = error {
                print("Facebook login error: \(error.localizedDescription)")
                return
            }
            
            guard let token = AccessToken.current else {
                print("Failed to get Facebook access token")
                return
            }
            
            let request = GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token.tokenString, version: nil, httpMethod: .get)
            request.start { connection, result, error in
                if let error = error {
                    print("Failed to make graph request: \(error.localizedDescription)")
                    return
                }
                
                if let result = result as? [String: Any] {
                    print("Facebook login result: \(result)")
                    
                }
            }
            
        }
        
    }
    }
    

