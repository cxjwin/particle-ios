//
//  CustomURLProtocol.swift
//  Demo
//
//  Created by smart on 2023/6/4.
//

import UIKit

class CustomURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        // 检查URL是否匹配我们需要拦截的域名
        if let url = request.url, url.host == "auth.particle.network" {
            return true
        }
        return false
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        var request = request
        // 修改请求的URL，将其重定向到我们的服务器
        if let newURL = URL(string: "https://auth.particle.network") {
            request.url = newURL
        }
        return request
    }

    override func startLoading() {
        // 在这里，你可以启动网络请求
    }

    override func stopLoading() {
        // 在这里，你可以停止网络请求
    }
}
