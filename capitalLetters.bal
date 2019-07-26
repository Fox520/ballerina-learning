// Returns only the uppercase letters in a string

import ballerina/io;

function getCapitals(string str) returns (string){
    string outputString = "";
    foreach string s in str.split(""){
        // Ignore spaces
        if(s.equalsIgnoreCase(" ")){
            continue;
        }
        // compare if is higher case
        boolean|error result = s.matches(s.toUpper());
        if(result is boolean){
            if (result){
                outputString = outputString + s;
            }
        }
    }
    return outputString;
}

public function main(){
    string testString = "ThIs IS aN eXamPle";
    string output = getCapitals(testString);
    io:println(output);
}
