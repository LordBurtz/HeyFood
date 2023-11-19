//
//  WebView.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    
    // 1
    let url: URL

    
    // 2
    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()
    }
    
    // 3
    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

#Preview {
    WebView(url: URL(string: "http://example.org")!)
}
