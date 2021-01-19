import UIKit

let name: String? = "Honey"

let optionalSome = Optional.some("Bob")
let optionalNone: String? = Optional.none


print(optionalSome == nil)
print(optionalNone == nil)

// unwrap the value to work with optionals
if let someName = name {
    print(someName)
} else {
    print("My dog doesn't have a name")
}

if let anotherName = optionalNone {
    print("my dog's other name is \(anotherName)")
} else {
    print("no dog alt name")
}

func formulateDogName() -> String? {
    guard let theName = name else {
        print("My dog doesn't have a name!")
        return nil
    }
    
    guard let lastName = optionalSome else { return nil }
    
    return "Dog name: \(lastName), \(theName)"
}

formulateDogName()

func foo(bar: String?) {
    let biz = bar?.hasPrefix("H")
    let baz = bar ?? "Bob"
    // what are the types for biz and baz and what's going on???
}

// optional chaining when calling methods on optional types
let hasPrefix = name?.hasPrefix("H")

func getOrElse<T>(_ value: T?, defaultValue: T) -> T {
    if let unwrappedValue = value {
        return unwrappedValue
    } else {
        return defaultValue
    }
}

let dogName = getOrElse(name, defaultValue: "Bob")
let dogName2 = name ?? "Bob"

let unwrappedName = name

func guardExample(a: String?) -> Void {
    guard let b = a else {
        print("none")
        return
    }
    
    print(b)
}

// use optionals for "center field" exception handling

func handleNumberOfDogsApi(apiResponse: String) -> Bool {
    guard let data = apiResponse.data(using: .utf8) else { return false }
    
    // [key: value]
    // [type]
    guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return false }
    
    guard let numberOfDogs = jsonObject["number_of_dogs"] as? Int else { return false }
    
    return numberOfDogs == 4
}

func getNumberOfDog(from apiResponse: String) -> Int? {
    guard let data = apiResponse.data(using: .utf8) else { return nil }
    
    // [key: value]
    // [type]
    guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
    
    guard let numberOfDogs = jsonObject["number_of_dogs"] as? Int else { return nil }
    
    return numberOfDogs
}

let numberOfDogs = getNumberOfDog(from: "{\"number_of_dogs\": 4}")
print(numberOfDogs)
