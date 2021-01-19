import UIKit

// closure is a function type ((_ bar: String) -> String)
let foo = { (_ bar: String) -> String in
    return "\(bar).jpg"
}

foo("honey")

let baz = { (_ bar: String) -> String in
    return "\(bar).png"
}("bob")

foo("honey scriggins")

func anotherFunction(_ a: String) -> String {
    return "I love Sam's Dogs"
}

struct MyOptional<V> {
    let theValue: V?
    func map<T>(transform: ((V) -> T)) -> T? {
        guard let value = self.theValue else { return nil }
        return transform(value)
    }
}

let name: String? = "Honey"
let nilName: String? = nil

let isBestDog = name.map({ (_ s: String) -> Bool in
    print(s)
    return s == "Bob"
})

let notADog = nilName.map({ (_ s: String) -> Bool in
    print(s)
    return s == "Bob"
})

let encoded0 = name?.data(using: .utf8)

/**
 Write me a map function that:
  - Takes the string argument and appends the string ".jpg" to the end
  - Convert that string to Data using utf8
  - returning variable be of type Data?
 */

let mydata = name.map { (_ s: String) -> Data in
    guard let data = "\(s).jpg".data(using: .utf8) else {
        return Data()
    }
    
    return data
}

let iLikeToFailAssignments = name.map { (_ s: String) -> Data in
    return "\(s).jpg".data(using: .utf8)!
}

// if the optional is nil, return nil
// if the return value is nil, return nil
// if the result value is of Type T, return T
extension MyOptional {
    func flatMap<T>(transform: ((_ value: V) -> T?)) -> T? {
        guard let value = self.theValue else { return nil }
        return transform(value)
    }
}

let iLikeToPassAssignemnts = name.flatMap { (_ s: String) -> Data? in
    return "\(s).jpg".data(using: .utf8)
}

let fileName = name.map { "dog_pictures/" + $0 } ?? "dog_pictures/honey.jpg"
