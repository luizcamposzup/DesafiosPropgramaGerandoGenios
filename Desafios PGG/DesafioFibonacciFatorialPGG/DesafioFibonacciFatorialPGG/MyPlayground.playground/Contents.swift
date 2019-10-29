import UIKit

var n: Int = 7

//func factorial(n: Int) -> Int {
//    var f: Int = 1;
//    for i in 1...n {
//        f *= i
//    }
//    print(f)
//    return (f)
//}
//
//
//func fibonacci(_ n: Int) -> Int {
//    var a = 1
//    var b = 1
//    guard n > 1 else { return a }
//
//    (3...n) .forEach { _ in
//        (a, b) = (a + b, a)
//    }
//    print(a)
//    return (a)
//}

//
//func fib1(_ n: Int) -> Int {
//    var fibs: [Int] = [1, 1]
//    (2...n).forEach { i in
//        fibs.append(fibs[i - 1] + fibs[i - 2])
//    }
//    return fibs.last!
//}
//
//func fib2(_ n: Int) -> Int {
//    guard n > 1 else { return n }
//    return fib(n-1) + fib(n-2)
//}

func fibonacci (n: Int) -> Int {
    
    if (n <= 2) {
        return 1
    } else {
        return fibonacci(n: n-1) + fibonacci(n: n-2)
    }
}

func factorial (n: Int) -> Int {
    if n <= 1 {
        return 1
    } else {
        return n * factorial(n: n-1)
    }
}


factorial(n: n)
fibonacci(n: n)
//fib1(n)
//fib2(n)

