//
//  Result.swift
//  TIH API via present
//
//  Created by Ryan Lin on 2023/3/21.
//

import Foundation

struct Result: Decodable {
    let status: Info
    let data: [Hotel]
}

struct Info: Decodable {
    let code: Int
    let name: String
    let message: String
}

struct Hotel: Decodable {
    let name: String
    let description: String
    let body: String
    let rating:Double
    let location: Coordinate
    let address: AddressDetail
    let contact: ContactNo
    let images: [Photo]
    let reviews: [Review]
    let group: String
    let officialWebsite: String
}

struct Coordinate: Decodable {
    let latitude: Double
    let longitude: Double
}

struct AddressDetail: Decodable {
    let streetName: String
    let postalCode: String
}

struct ContactNo: Decodable {
    let primaryContactNo: String
}

struct Photo: Decodable {
    let uuid: String
    let url: String
}

struct Review: Decodable {
    let authorName: String
    let rating: Double
    let text: String
    let time: Date
}
