//
//  WebSocket.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/9/23.
//

import Foundation

class WebSocket: NSObject, ObservableObject, URLSessionWebSocketDelegate {
//    struct ReceivedMessage: Codable, Equatable {
//        enum MessageType: String, Codable, Equatable {
//            case documentText
//        }
//
//        var type: MessageType
//        var documentText: String
//    }
//
    enum SocketState {
        case closed
        case open
    }
    
    private class SessionDelegate: NSObject, URLSessionWebSocketDelegate {
        var didConnectCallback: () -> Void = {}
        var didCloseCallback: () -> Void = {}
        
        func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
            didConnectCallback()
        }
        
        func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
            didCloseCallback()
        }
    }
    
    private var webSocketDelegate: SessionDelegate = SessionDelegate()

    private var url: URL
    private var session: URLSession
    private var webSocketTask: URLSessionWebSocketTask
    private let queue = OperationQueue()
    
    @Published var socketState: SocketState = .closed
    @Published var receivedMessages: [String] = []
    
    init(_ connectionURL: URL) {
        self.url = connectionURL
        self.session = URLSession(configuration: .default, delegate: webSocketDelegate, delegateQueue: queue)
        self.webSocketTask = session.webSocketTask(with: url)
        
        super.init()
        
        webSocketTask.resume()
        self.webSocketDelegate.didConnectCallback = didConnect
        self.webSocketDelegate.didCloseCallback = didClose
    }
    
    func disconnect() {
        webSocketTask.cancel(with: .goingAway, reason: nil)
    }
}

// MARK: Web Socket delegate functions
extension WebSocket {
    func didConnect() {
        Dispatch.main {
            self.socketState = .open
        }
    }
    
    func didClose() {
        Dispatch.main {
            self.socketState = .closed
        }
    }
}

// MARK: Send Data
extension WebSocket {
    func send(message: String) async throws {
        if socketState == .closed { return }
        
        let message = URLSessionWebSocketTask.Message.string(message)
        try await webSocketTask.send(message)
    }
    
    func send(data: Data) async throws {
        if socketState == .closed { return }

        let message = URLSessionWebSocketTask.Message.data(data)
        try await webSocketTask.send(message)
    }
}

// MARK: Receive Data
extension WebSocket {
    func receive() async throws {
        if socketState == .closed { return }

        let result = try await webSocketTask.receive()

        switch result {
        case .string(let string):
//            let decoder = JSONDecoder()
//            print(string)
//            let message = try decoder.decode(ReceivedMessage.self, from: string.data(using: .utf8)!)
            
            Dispatch.main {
                self.receivedMessages.append(string)
            }
        case .data(let data):
//            let decoder = JSONDecoder()
//            let message = try decoder.decode(ReceivedMessage.self, from: data)
            
            Dispatch.main {
                self.receivedMessages.append(String(data: data, encoding: .utf8) ?? "Invalid Data")
            }
        @unknown default:
            fatalError("Unkown Value Recieved")
        }
        
        try await receive()
    }
}
