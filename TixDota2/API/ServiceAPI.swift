//
//  ServiceAPI.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 30/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//
//
//import Foundation
//import ReactiveSwift
//import Moya
//
//func JSONObjectWithArray(data: Data) -> [[String: Any]]? {
//	if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
//		return json
//	}
//	return .none
//}
//
//func JSONObjectWithData(data: Data) -> [String: Any]? {
//	if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//		return json
//	}
//	return .none
//}
//
//func backgroundDecodeSignalWithReponse<T: Argo.Decodable>(jsonData: Any?, response: Response) -> SignalProducer<(Response, T?)?, APIError> where T.DecodedType == T {
//	return SignalProducer { observer, requestDisposable in
//		DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
//			let decoded:Decoded<T>? = jsonData.flatMap(decode)
//
//			guard let decodedValue = decoded else {
//				observer.send(value: .none)
//				return
//			}
//			switch decodedValue {
//			case Decoded.failure(let errorDecode):
//				observer.send(error: APIErrorFactory(decodeError: errorDecode))
//			case Decoded.success(let model):
//				observer.send(value: (response, model))
//			}
//		}
//	}
//}
//
//func backgroundDecodeSignal<T: Argo.Decodable>(jsonData: Any?) -> SignalProducer<T?, APIError> where T.DecodedType == T {
//	return SignalProducer { observer, requestDisposable in
//		DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
//			let decoded:Decoded<T>? = jsonData.flatMap(decode)
//
//			guard let decodedValue = decoded else {
//				observer.send(value: .none)
//				return
//			}
//			switch decodedValue {
//			case Decoded.failure(let errorDecode):
//				observer.send(error: APIErrorFactory(decodeError: errorDecode))
//			case Decoded.success(let model):
//				observer.send(value: model)
//			}
//		}
//	}
//}
//
//func backgroundDecodeSignal<T: Argo.Decodable>(jsonData: Any?) -> SignalProducer<[T]?, APIError> where T.DecodedType == T {
//	return SignalProducer { observer, requestDisposable in
//		DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
//			let decoded:Decoded<[T]>? = jsonData.flatMap(decode)
//
//			guard let decodedValue = decoded else {
//				observer.send(value: .none)
//				return
//			}
//			switch decodedValue {
//			case Decoded.failure(let errorDecode):
//				observer.send(error: APIErrorFactory(decodeError: errorDecode))
//			case Decoded.success(let model):
//				observer.send(value: model)
//			}
//		}
//	}
//}
//
//let networkBackgroundQueue = DispatchQueue(label: "com.moviekita.network.queue")
//
//func request<T: APITarget, S:Argo.Decodable> (_ API: T, provider:MoyaProvider<T>, jsonObject: @escaping (Data) -> Any?) -> SignalProducer<S?, APIError> where S.DecodedType == S {
//	let scheduler = QueueScheduler(qos: .default, name: "com.moviekita.queue.scheduler", targeting: networkBackgroundQueue)
//	return provider
//		.reactive
//		.request(API)
//		.start(on: scheduler)
//		.mapError({ (error) in
//			return APIErrorFactory(response: error.response ?? Response(statusCode: 500, data: Data()))
//		})
//		.filterResponseCode(range: 200...299)
//		.flatMap(.merge, {(response)  in
//			return backgroundDecodeSignal(jsonData: jsonObject(response.data))
//		})
//		.observe(on: UIScheduler())
//		.on(
//			failed: { (error) -> () in
//				switch error {
//				default:
//					break
//				}
//		})
//}
//
//func request<T: APITarget, S: Argo.Decodable> (_ API: T, provider: MoyaProvider<T>, jsonObject: @escaping (Data) -> Any?) -> SignalProducer<[S]?, APIError> where S.DecodedType == S {
//	let scheduler = QueueScheduler(qos: .default, name: "com.moviekita.queue.scheduler", targeting: networkBackgroundQueue)
//	return provider
//		.reactive
//		.request(API)
//		.start(on: scheduler)
//		.mapError({ (error) in
//			return APIErrorFactory(response: error.response ?? Response(statusCode: 500, data: Data()))
//		})
//		.filterResponseCode(range: 200...299)
//		.flatMap(.merge, {(response) in
//			return backgroundDecodeSignal(jsonData: jsonObject(response.data))
//		})
//		.observe(on: UIScheduler())
//		.on(
//			failed: { (error) -> () in
//				switch error {
//				default:
//					break
//				}
//		}
//	)
//}
