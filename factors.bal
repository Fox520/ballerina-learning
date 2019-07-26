// Finds the factors of a random number

import ballerina/io;
import ballerina/math;

public function main(){
    // Generate the random number
    int randomNum = math:randomInRange(10, 61);
    // Store all numbers below in array
    int[] numsBelow = [];
    foreach int i in 1 ..<randomNum{
        numsBelow[numsBelow.length()] = i;
    }

    // Find and store the factors
    any[] factors = [];
    foreach int i in 0 ..<numsBelow.length(){
        int currentNum = numsBelow[i];
        // Make sure we don't double check a value
        foreach int j in currentNum ..<numsBelow.length(){
            int prod = currentNum * numsBelow[j];
            if(prod == randomNum){
                // Add to array of factors
                // Convert int since key needs to be string
                map<any> m = {string.convert(numsBelow[i]) : numsBelow[j]};
                factors[factors.length()] = m;
                
            }
        }
    }
    map<any> output = {};
    output["the random number is"] = randomNum;
    output["its factors are"] = factors;
    io:println(output);
    // {"the random number is":12, "its factors are":[{"2":6}, {"3":4}]}
}
