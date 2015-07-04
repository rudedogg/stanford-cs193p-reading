//: Playground - noun: a place where people can play

import UIKit


/* The Basics */

/* Numeric Literals */
// Integer Literals
let decimalInteger = 22
let binaryInteger = 0b10 // 2 in binary
let octalInteger = 0o31
let hexadecimalInteger = 0x1A

// Floating Point Literals
// to define a floating point literal in hex/decimal they need a number on both sides of the decimal point
// they can have an exponent as well
var floatingPointHex = 0xC.3p0
var doubleWithExponent = 1.25e10

// formatting literals for readability
// using '_' and padding with leading zeros doesn't affect the value
var oneMillion = 1_000_000
var paddedDouble = 000123.456


/* Numeric Type Conversion */
// Only use Int16, UInt16, etc when required for performance, memory usage, or other required optimizations - and compatibility with an outside API/data sources

// Integer Conversion
// let cannotBeNegative: UInt8 = -1  // generate compile time error, cannot put a negative in an unsigned int
// let tooBig: Int8 = Int8.max + 1

// Type conversion for specific number types is handled in an "opt-in" way to prevent unexpected type conversions - you must be explicit
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
// let twoThousandAndOne = twoThousand + one // type error
let twoThousandAndOne = twoThousand + UInt16(one)

// behind the scenes the UInt16 type has an initializer that accepts a UInt8 type.  Due to that, not all types can be used in the UInt16() initializer call
// Allowing UInt16 to accept additional types (including custom types) is covered in the section titled "Extensions"


// Integer and Floating-Point Conversion
// conversions between Integers and Floating Point types must be explicit as well
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine

// Floating-Point to Int must be explicit too
// Initializing a new Int using a floating-point source will always truncate the value
let integerPi = Int(pi)

let allowed = 3 + 0.145 // allowed since the literals have no type, it is only infered at compile time when evaluated


/* Type Aliases */
// Type aliases define an alternative name for an existing type.
// An alias can be used to create descriptive types/names when working with an external data source
typealias AudioSample = UInt16
AudioSample.max


/* Tuples */
// tuples group multiple values into a single compound value. The values can be of any type
var notFound = (404, "Not Found")
// the notFound tuple can be described as "a tuple of type (Int, String)"
// you can have any number or combination of types (Int, Int, Int), (Bool, Int, UInt16), etc

// to get specific values from a tuple, you "decompose" them:
let (statusCode, statusMessage) = notFound
print(statusMessage)


// to skip values use _
let (_, newStatusMessage) = notFound
print(newStatusMessage)

// tuples can also be accessed using index values and dot notation:
notFound.0

// elements can also be named
let myName = (first: "Austin", last: "Rude")
myName.first
myName.0 // index values still work

// Tuples are useful as return values for functions.  It's a method to return multiple values from a function
// Tuples are good for temporary data in a single scope, if the data will be passed to other scopes or is complex then a struct or class is more appropriate



/* Basic Operators */
// Nil Coalescing Operator
// Provides an elegent way to do conditional checking and unwrap the optional

// unwraps an optional a if it contains a value, otherwise returns b
// b must be the same type of a
// (a ?? b)
// if a != nil, it short-circuits (b never is evaluated)

// shorthand of the following ternary conditional operator syntax:
// a!= nil a! : b

let defaultColorName = "Red"
var userDefinedColorName: String?

var colorName = (userDefinedColorName ?? defaultColorName)



/* Strings and Characters */
// Remeber strings are value types, you are always working with a copy when passing them to a function, etc.
// NSString in cocoa is different, when creating an NSString instance and passing it to a function, you are passing a reference! You only use a copy when specifically requesting it!

// Unicode
// Swift's String and Unicode types are fully unicode compliant

// Unicode Scalars
// Behind the scenes the String type is built from Unicode scalar values
// Unicode scalar is a 21 bit number for a character or modifier, such as U+0061 for "a" or U+1F425 for "FRONT-FACING BABY CHICK" - 🐥

// unicode scalar - u{1-8 digit hex number}
let heart = "\u{1F496}"


// Extended Grapheme Clusters
// A Character instance represents an extended grapheme cluster
// an extended grapheme cluster is a sequence of one or more unicode scalars that produce a single human-readable character
let eAcute = "\u{00e9}" // Character type
let eAcute2 = "\u{65}\u{301}" // Character type

let testString = "T\u{65}\u{301}his is just a test"
let testIndex = testString.startIndex.successor() // successor returns the next human-readable Character
testString[testIndex]
let testIndex2 = testString.endIndex.predecessor() // predecessor returns the previous human-readable Character
testString[testIndex2]

/* Unicode Representations of Strings */
let dogString = "Dog\u{203C}\u{1F436}"
// UTF-8 uses an 8-bit(using UInt8 values) representation for each character
for char in dogString.utf8 {print(char)}
// UTF-16 uses a 16-bit(using UInt16 values) representation for each character
for char in dogString.utf16 {print(char)}
// Unicode Scalar Representation uses a 21-bit(using UInt32 values) representation for each character
for char in dogString.unicodeScalars {print(char)}



/* Collection Types */
// Dictionaries
// unordered key/value store
// Swift's Dictionary type is bridged with Foundation's NSDictionary class
// A dictionary key MUST conform to the Hashable protocol
var dict = [Int: String]()
dict[0] = "Zero"
dict[1] = "One"
dict
dict.count
// empty a dictionary
// dict = [:] // keeps types

// create a dictionary with a dictionary literal
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// test if dict has data
airports.isEmpty

// update an existing value
airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"
airports.updateValue("London", forKey: "LHR")
airports

// remove a pair
airports["LHR"] = nil
airports.removeValueForKey("DUB")
airports

// Loop over a Dictionary
for (key, value) in airports {
    print(key)
    print(value)
}

// get the keys or values into an Array
var airportsArray = [String](airports.keys)



/* Control Flow */
// Tuples
// Tuples can be used to test multiple values in a switch statement
// If you want to accept any value in the tuple, use _
let somePoint = (1, 0)

switch somePoint {
case (0, 0):
    print("At the center")
case (0, _):
    print("On the x-axis")
case (_, 0):
    print("On the y-axis")
case (-2...2, -2...2):
    print("In a box between (-2, -2) and (2, 2)")
default:
    print("At \(somePoint.0), \(somePoint.1)")
}
// unlike C, swift allows multiple matching switch cases.  When multiples matches are possible, the first matching case is always used


// Value Bindings
// a switch case can bind values it matches to temporary variables/constants:
var someOtherPoint = (1, 5)

switch someOtherPoint {
case (0, let y):
    print("On the x-axis, at \(y)")
case (let x, 0):
    print("On the y-axis, at \(x)")
case let (x, y): // since this case matches all other possible values, a default case is not required!
    print("At \(x), \(y)")
}
// var and let work, if using var the variable is only for the scope/lifetime of the case


// Where
// a switch case can use a where clause to check for additional conditions
someOtherPoint = (5, 5)
switch someOtherPoint {
case (let x, let y) where x == y:
    print("\(x) == \(y) is on the line where x == y")
case (let x, let y) where x == -y:
    print("\(x) == \(y) is on the line where x == -y")
case let (x, y):
    print("At \(x), \(y)")
}
// the switch case only matches if the where condition evaluates to true



/* Functions */
// Functions with Multiple Return Values
