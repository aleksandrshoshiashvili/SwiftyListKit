//
//  User.swift
//  DemoApp
//
//  Created by Alexander Shoshiashvili on 12.05.2020.
//  Copyright © 2020 Alexander Shoshiashvili. All rights reserved.
//

import UIKit

struct User {
    
    let imageName: String
    let name: String
    let info: String
    let aboutMe: String
    var favouriteApps: [String]

}

extension User {
        
    static var users: [User] {
        [iosDeveloper, androidDeveloper, randomUser]
    }
    
    static var iosDeveloper: User {
        .init(imageName: "iosDeveloper",
              name: "John Doe",
              info: "iOS Developer ❤️ Swift",
              aboutMe: "Ante metus dictum at tempor commodo ullamcorper a lacus vestibulum. Ac tortor vitae purus faucibus ornare suspendisse sed nisi lacus. Nisl pretium fusce id velit. Est velit egestas dui id. Amet facilisis magna etiam tempor orci. Magna etiam tempor orci eu. Aliquet nibh praesent tristique magna sit. Sapien faucibus et molestie ac. Tellus molestie nunc non blandit. Condimentum lacinia quis vel eros. Amet consectetur adipiscing elit ut aliquam purus sit amet. Sit amet dictum sit amet justo donec enim diam. Et odio pellentesque diam volutpat commodo. Facilisis gravida neque convallis a cras semper auctor neque. Et netus et malesuada fames. Facilisis magna etiam tempor orci eu lobortis. Vestibulum morbi blandit cursus risus at ultrices mi.",
              favouriteApps: ["Telekom", "Flaschenpost", "Vonovia"])
    }
    
    static var androidDeveloper: User {
        .init(imageName: "androidDeveloper",
              name: "John Doe",
              info: "Android Developer ❤️ Kotlin",
              aboutMe: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quam pellentesque nec nam aliquam sem et tortor. Lorem donec massa sapien faucibus et molestie ac. Condimentum vitae sapien pellentesque habitant morbi. Eu ultrices vitae auctor eu augue. Sed libero enim sed faucibus. Turpis egestas maecenas pharetra convallis posuere morbi leo urna molestie. Elit ullamcorper dignissim cras tincidunt lobortis. Risus in hendrerit gravida rutrum quisque. Tellus elementum sagittis vitae et leo duis ut. Gravida cum sociis natoque penatibus et magnis dis parturient montes. Lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare.",
              favouriteApps: ["Kuntze instruments", "Sport im Osten", "Dlf Auditohek"])
    }
    
    static var randomUser: User {
        .init(imageName: "placeholder",
              name: .randomString(length: 20),
              info: .randomString(length: 140),
              aboutMe: .randomString(length: 500),
              favouriteApps: Array(repeating: String.randomString(), count: 5))
    }
    
    static func getRandomUser() -> User {
        [User.randomUser, User.iosDeveloper, User.androidDeveloper].randomElement()!
    }
}
