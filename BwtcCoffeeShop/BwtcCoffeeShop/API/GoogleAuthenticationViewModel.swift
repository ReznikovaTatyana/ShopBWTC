//
//  AuthenticationViewModel.swift
//  BwtcCoffeeShop
//
//  Created by mac on 18.03.2024.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}


final class GoogleAuthenticationViewModel: NSObject {
    
    public func signInGoogle(completion: @escaping (Error?) -> Void) {
        DispatchQueue.main.async {
            guard let topVC = UIApplication.shared.windows.first?.rootViewController else {
                completion(URLError(.cannotFindHost))
                return
            }
            
            Task {
                do {
                    let gidSignResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
                    
                    let user = gidSignResult.user
                    
                    guard let idToken = user.idToken?.tokenString else {
                        throw URLError(.badServerResponse)
                    }
                    
                    let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: user.accessToken.tokenString)
                    completion(nil)
                } catch {
                    completion(error)
                }
            }
        }
    }
    
    
   
    
    
}
