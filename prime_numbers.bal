// Find prime numbers in a random range
import ballerina/io;
import ballerina/math;

public function main(){
    int randomNumber = math:randomInRange(1, 201);
    json m = {};
    m["the small number is"] = 1;
    m["the big number is"] = randomNumber;
    m["prime numbers in range"] = [];
    
    foreach int n in 1...randomNumber{
        if(isPrime(n)){
            m["prime numbers in range"][m["prime numbers in range"].length()] = {string.convert(n):1};
        }
    }
    io:println(m);
}

function isPrime(int n) returns boolean{
    foreach int i in 2..<n {
        if(n%i == 0){
            return false;
        }
    }
    return true;
}

//{”the small number is” : value, ”the big number is” : value, ”prime numbers in range” : [{prime i : value}, {prime j: value}, . . .]}
