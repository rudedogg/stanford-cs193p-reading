//: Playground - noun: a place where people can play

import UIKit



/* Constants And Variables */

// define a constant - can only be assigned a value exactly once.  Always use if the value isn't going to change!
let myConstant = 1

// myConstant = 5 - not allowed, the constant has already been assigned a value.  This won't compile


// define a variable without declaring the type explicitly (type inference)
var answerToEverything = 42

// Declare multiple variables on one line
var x = 1, y = 2.0, z = "Hello"

// Type annotation - think of the colon  as meaning "...of type..."
var welcomeMessage: String
// welcomeMessage = getWelcomeMessage() // dynamically set the welcomeMessage

// It is bad practice to use a type annotation when the type can be inferred. A type annotation makes more sense if the variable doesn't have an initial value
var welcomeMessage2: String = "This is bad practice, don't do this"

// Declare multiple variables of the same type
var red, green, blue: Double

let π = 3.14159
print(π)

// Only use a reserved keyword if you have no choice.  Keywords can be escaped with `backticks`
let `let` = 5


// "string interpolation" - output a variable as a string, useful for print()/debugging
print("WelcomeMessage2 = \(welcomeMessage2)")



/* Comments */

// Single line

/* Multiline
   comment
   //How cool
  /* Even nested mutiline comments are allowed! */
*/



/* Semicolons */
print("Who needs semicolons?")
print("I do"); print("..")



/* Integer */
// Integers can be signed (negative, 0, and positive) or unsigned (positive of 0)
// Has 8, 16, 32, and 64 bit integers
var unsignedEightBitInt: UInt8
// unsignedEightBitInt = -2  // causes integer overflow

// 32-bit signed integer is type Int32

// All types in swift have a capitalized name

print(UInt8.min)
print(UInt8.max)
print(Int32.min)
print(Int32.max)

print(Int.min)
print(Int.max)
// Usually you just want to use "Int" - which will be 32 or 64 bit - whichever is native on the platform the code is executed
// On 32 bit platform, Int = Int32
// On 64 bit platform, Int = Int64

// Similar to Int8, Int 16, etc, there is a UInt type for unsigned 32/64 bit integers, which has the same size as the current platform
print(UInt.min)
print(UInt.max)

// Even if you are only storing postive values, using Int is preferred (code interoperability, type inference, etc).  Only use UInt if you actually need the extra storage range.



/* Floating-Point Numbers */
// Double = 64 bit
// Float = 32 bit

// using Double is preferred
// Double has a precision of at least 15 decimal digits
// Float can have a precision of as little as 6 decimal digits
var myDouble = 1.123456789
var myFloat: Float = 1.123456789



/* Type Safety and Type Inference */
// Swift is type safe
// Performs type checks when compiling code, and flags any mismatched types so you can fix them early in the development process

// type safe != always specifying the type of every variable
// type inference is there so you don't have to do that

let pi = 3.14159 // type inference knows we want a Double (Swift always chooses Double rather than float when infering the type)
let meaningOfLife = 42 // type inference knows we want an Int

let anotherPi = 3 + 0.14159 // Swift knows this should be a Double (because 3 is a literal, if 3 were a var, we'd need to cast it using Double(three))



/* Booleans */
// the type name is "Bool"
// In swift boolean values are "logical" - that means they can only be either true or false
let orangesAreOrange = true  // type is inferred as Bool when initialized to true/false
let turnipsAreDelicious = false

// A Bool makes a handy if condition
if turnipsAreDelicious {
    print("I LOVE turnips!")
}
else {
    print("Eww, turnips")
}

let i = 1

// this is a compile time error, a Bool can only be true/false!
//if i {
//}
if i == 1 {
    print("i==1")
}



/* Optionals */
// An optional means, there is a value and it is x, or there isn't a value at all
// Optionals are a new feature not in C/Objective-C
// Optionals can be used for ANY TYPE!

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be an Int? ("optional integer")

// to set an optional to a valueless state you can set it to nil
// again, this just clears to value
var serverResponseCode: Int? = 404
serverResponseCode = nil

// nil CANNOT be used with nonoptional constants and variables.  If you need to clear a variable, it should be declared as an optional!

// in objective-c nil is a pointer to a nonexistent object, in swift nul is the abscense of a value.  Optionals of any type can be set to nul, not just object types,

// to check if an optional has a value, simple compare to nil

if convertedNumber != nil {
    print(convertedNumber)
    
    // Since we checked and convertedNumber definitely has a value, we can unwrap it for display (this is called "forced unwrapping"
    print("Optionals need unwraped \(convertedNumber!)")
}

// using ! to access a non-existent option value triggers a runtime error.  Don't let it happen - check != nil first!

// Optional Binding
// Optional binding can be used on if and while statements
// If the value exists, it extracts it to a temp variable, all in one step
var someOptional: String? = "Test"
var someOptional2: String?

// the temp variable can be a constant
if let constantName = someOptional {
    print(constantName)
}

// Nothing is output, the if is skipped since someOptional2 doesn't have a value
if var varName = someOptional2 {
    print(varName)
}


// Int().init?(string) allows this to work (it returns an optional). Pattern should be useful.
// can be either a variable or constant
if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
}
else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}


// multiple optional bindings - both must have a value
if let actualNumber = Int(possibleNumber), var varName = someOptional {
    print(actualNumber)
    print(someOptional2)
}

// implicitly unwrapped optionals
// Used when you know an optional will always have a value after it is set, and makes it so you don't have to unwrap it to use it
// think of it as giving permission for the optional to be unwrapped automatically
// declared with a `!` following the type, rather than a `?`
let newOptional: String! = "Testing"
print(newOptional)


if newOptional != nil {
    print(newOptional) // check isn't required but is allowed.  Should use a normal Optional instead in this case though!
}

// combining implicitly unwrapped optional and option binding to create a var that is implicitly unwrapped
if let definiteString = newOptional {
    print(definiteString)
}



/* Assertions */
// Use assertions when a value can be false, but MUST be true to continue.  Not an alternative for properly checking things in code and working with the user, but useful for development

// this triggers the assertion, true is not = to false
//assert(true==false, "Descriptive message to help debug the assert")

// message is optional
//assert(1>=2)


/* Basic Operators */
/* Assignment Operator */
// Assign multiple values using tuples
let (x1, y1) = (1, 2)
print(x1)
print(y1)

print("Strings can be " + "concatenated with +")

/* Modulo/Remainder */
10 % 3
// Works for floating point too :)
1 % 0.99
// And negatives
10 % -8
-10 % 8

// Unary minus operator - toggles the sign - + becomes -, - becomes +
var x3 = 300
-x3
var x4 = -400
-x4

x3 += x4
