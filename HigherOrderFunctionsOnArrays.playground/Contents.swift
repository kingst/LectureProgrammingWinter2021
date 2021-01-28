import UIKit

// map: transform an array of one type to another type
let names = ["Honey.png", "Milo.jpg", "Annie.jpg", "Bob.png"]
// [String] -> [String] both arrays are the same length
let paths = names.map { "pictures/" + $0 }

print(paths)

// filter: return a subarray of the source array
// [String] -> [String] but result may have fewer elements
let jpegs = names.filter { $0.hasSuffix(".jpg") }
print(jpegs)

// chain these together
// [String] -> [String] -> [String]
let jpegPaths = names.filter({ $0.hasSuffix(".jpg") }).map { "pictures/\($0)" }
print(jpegPaths)

let foo = "Foo"
let fooInBytes = foo.data(using: .utf8)

// compact map will unwrap your closures optional return value and only return
// elements that are some. This means that the resulting array might be
// smaller than the source
// [String] -> [Data]
let dataNames = names.compactMap { $0.data(using: .utf8) }

let concreteOnly = names.compactMap { $0 }

// [String] -> [Data?]
let mappedDataNames = names.map { (_ str: String) -> Data? in
    return str.data(using: .utf8)
}

if let data = "asdfasdf".data(using: .utf8) {
    // reduce to convert these bytes to a hex string
    // Data (byte array) -> [String] -> String
    let hex0 = data.map({ String(format: "%02x", $0) }).reduce("0x") { $0 + $1 }
    print(hex0)
    
    let hex1 = data.reduce("0x") { "0x" + $0 + String(format: "%02x", $1) }
    print(hex1)
}

class MyArray<T> {
    let theArray: [T]
    init(_ array: [T]) {
        theArray = array
    }
    
    func map<V>(transform: ((_ value: T) -> V)) -> [V] {
        var result: [V] = []
        for item in theArray {
            result.append(transform(item))
        }
        return result
    }
    
    func compactMap<V>(transform: ((_ value: T) -> V?)) -> [V] {
        var result: [V] = []
        for item in theArray {
            if let something = transform(item) {
                result.append(something)
            }
        }
        return result
    }
    
    // implement reduce on your own
}

let dogs = [(2010, "bob"), (2020, "honey"), (2000, "annie"), (1999, "milo")]

// [(Int, String)] -> sorted -> [String]
let sortedDogNames = dogs.sorted(by: { $0.0 < $1.0 }).map { $0.1 }
print(sortedDogNames)

func nextDogsName( sortedDogs: [String], currentDog: String) -> String? {
    // zipped array -> [("milo", "annie"), ("annie", "bob"), ("bob", "honey")]
    for (current, next) in zip(sortedDogs, sortedDogs.dropFirst()) {
        if currentDog == current {
            return next
        }
    }
    
    return nil
}

print(nextDogsName(sortedDogs: sortedDogNames, currentDog: "bob"))
