//
//  OAuthService.swift
//  OnSiteX
//
//  Created by Victor Ramirez on 3/22/24.
//

//import Foundation
//import AuthenticationServices
//
//class OAuthService {
//    static let shared = OAuthService()
//    
//    func beginOAuthFlow(presentingViewController: UIViewController) {
//        // Define the OAuth URL. Replace with your actual backend URL for the OAuth route.
//        let authURL = URL(string: "https://yourbackenddomain.com/login")!
//        
//        // Create an ASWebAuthenticationSession instance
//        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "yourappscheme") { callbackURL, error in
//            // Handle callback with access token or error
//            guard error == nil, let callbackURL = callbackURL else {
//                print("Authentication error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            // Extract the access token from the callback URL.
//            // You'll need to modify this to match how your backend sends the token.
//            let token = self.extractToken(from: callbackURL)
//            
//            // Securely store the token and handle next steps...
//        }
//        
//        // Present the ASWebAuthenticationSession
//        session.presentationContextProvider = presentingViewController as? ASWebAuthenticationPresentationContextProviding
//        session.start()
//    }
//    
//    private func extractToken(from url: URL) -> String {
//        // Extract the access token from the URL
//        // You'll need to adjust this based on how your backend returns the token.
//        return url.queryParameters?["access_token"] ?? ""
//    }
//}
//
//extension URL {
//    var queryParameters: [String: String]? {
//        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
//              let queryItems = components.queryItems else { return nil }
//        return queryItems.reduce(into: [String: String]()) { result, item in
//            result[item.name] = item.value
//        }
//    }
//}
//
//extension UIViewController: ASWebAuthenticationPresentationContextProviding {
//    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//}
