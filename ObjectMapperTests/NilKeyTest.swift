//
//  NilKeyTest.swift
//  ObjectMapper
//
//  Created by Jonathan Saggau on 11/7/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import XCTest
import ObjectMapper

class NilKeyTests: XCTestCase {
	
	func testUserBasicStaticMappableIgnoreNull(){
		let namePreMap = User.basic.name
		let JSON = "{\"name\" : null}"
		let user = Mapper<User>().map(JSON)
		
		XCTAssertEqual(user!.name, namePreMap)
		XCTAssertTrue(user === User.basic)
	}
	
	func testIgnoreNilKey(){
		let name = "Tristan"
		var user = User(name)
		
		let fozzy = "Bear"
		let JSON = "{\"fozzy\" : \"\(fozzy)\"}"
		user = Mapper<User>().map(JSON, toObject: user)
		
		XCTAssertEqual(user.name, name)
		XCTAssertEqual(user.fozzy, fozzy)
	}
	
	func testIgnoreNilKeyStaticMappable(){
		let namePreMap = User.basic.name
		let fozzy = "Bear"
		let JSON = "{\"fozzy\" : \"\(fozzy)\"}"
		let user = Mapper<User>().map(JSON)
		
		XCTAssertEqual(user!.name, namePreMap)
		XCTAssertTrue(user === User.basic)
	}
	
	func testStaticMappableChangingProperty(){
		let name = "Jim"
		let JSON = "{\"name\" : \"\(name)\"}"
		let user = Mapper<User>().map(JSON)
		
		XCTAssertEqual(user!.name, name)
		XCTAssertTrue(user === User.basic)

	}
	
	private class User: StaticMappable {
		static let basic = User("Johnny Five")
		
		var name: String?
		var fozzy: String?
		
		init(_ name: String? = nil){
			self.name = name
		}
		
		required init?(_ map: Map){
			
		}
		
		func mapping(map: Map){
			name <- map["name", ignoreNil: true]
			fozzy <- map["fozzy"]
		}
		
		static func objectForMapping(map: ObjectMapper.Map) -> BaseMappable? {
			return User.basic
		}
		
	}
	
}
