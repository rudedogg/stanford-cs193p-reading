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
// let cannotBeNegative: UInt8 = -1  // generated compile time error, cannot put a negative in an unsigned int

