public class LogicBuilding {
    
    // 18.Write a program to print all numbers backwards from 100 to 0 i.e. 100 99 98 97 96 . . . 4 3 2 1 0
    
    public static List<Integer> backwardNumSeries(){
        List<Integer> intList=new List<Integer>();
        for(Integer i=100;i>=0;i--){
            intList.add(i);
        }
        return intList;
    }
    
    //19.Write a program to print numbers backwards from 100 to 1 by skipping 2 numbers i.e. 100 97 94 91 88 
    //85 82 79. . . 22 19 16 13 10 7 4 1
    public static List<Integer> backwardSeriesSkip2(){
        List<Integer> intList=new List<Integer>();
        for(Integer i=100;i>0;i-=3){
            intList.add(i);
        }
        return intList;
    }
    
    //20.Write a program to print all the Numbers Divisible by 7 from 1 to 100.
    public static List<Integer> divisibleBy7(){
        List<Integer> numList=new List<Integer>();
        for(Integer i=1;i<=100;i++){
            if(Math.mod(i,7)==0){
                numList.add(i);
            }
        }
        return numList;
    }
    
    //21.Write a Program to print numbers n to 1 using Do While loop.
    public static List<Integer> printSeries(Integer n){
        List<Integer> intList=new List<Integer>();
        while(n>=1){
            intList.add(n);
            n--;
        }
        return intList;
    }
    
    //22.Write a Program to print numbers 1 to n using while loop.
    public static List<Integer> seriesUsingWhile(Integer n){
        List<Integer> intList=new List<Integer>();
        Integer i=1;
        while(i<=n){
            intList.add(i);
            i++;
        }
        return intList;
    }
    
    //23.Write a Program to print first n even numbers.
    public static List<Integer> nEvenNumber(Integer n){
        List<Integer> evenList=new List<Integer>();
        Integer count=0;
        for(Integer i=0;i<=2*n;i++){
            if(Math.mod(i,2)==0){
                evenList.add(i);
                count++;
                if(count>=n){
                    break;
                }
            }
        }
        return evenList;
    } 
    
    /* 24.Write a function that returns the last digit of the given number. 
Last digit is being referred to the least signiﬁcant digit i.e. the digit in the ones (units) place in the given number.
The last digit should be returned as a positive number. 
For example, 
if the given number is 197, the last digit is 7 
if the given number is -197, the last digit is 7 */
    
    public static Integer getLastDigit(Integer num){
        Integer digit=Math.mod(num,10);
        return Math.abs(digit);
    }
    
    /*25. Write a function that returns the second last digit of the given number. Second last digit is being referred to the digit in the tens place in the given number.
For example,
if the given number is 197, the second last digit is 9
Note1 - The second last digit should be returned as a positive number. i.e. if the given number is -197, 
the second last digit is 9
Note2 - If the given number is a single digit number, then the second last digit does not exist. 
In such cases, the function should return -1. i.e. if the given number is 5, the second last digit should be returned as -1
*/
    public static Integer getSecondLastDigit(Integer num){
        Integer n;
        if(num<10){
            return -1;
        }
        else{
            Integer lastDigit=Math.mod(num,10);
            num/=10;
            Integer secondLastDigit=Math.mod(num,10);
            n=Math.abs(secondLastDigit);
        } 
        return n;
    }
    
    /*26.Rohit wants to add the last digits of two given numbers. For example, If the given numbers are 267 and 154, 
the output should be 11. Below is the explanation -
Last digit of the 267 is 7
Last digit of the 154 is 4
Sum of 7 and 4 = 11
Write a program to help Rohit achieve this for any given two numbers.
The prototype of the method should be - int addLastDigits(int input1, int input2);
where input1 and input2 denote the two numbers whose last digits are to be added.
if the input numbers are 267 and 154, the sum of last two digits should be 11
if the input numbers are 267 and -154, the sum of last two digits should be 11
if the input numbers are -267 and 154, the sum of last two digits should be 11
if the input numbers are -267 and -154, the sum of last two digits should be 11 */
    public static Integer addLastDigits(Integer input1, Integer input2){
        Integer lastDigit1=Math.mod(input1,10);
        Integer lastDigit2=Math.mod(input2,10);
        return Math.abs(lastDigit1)+Math.abs(lastDigit2);
    }
    
    //27.Write a Program to print first n odd numbers.
    public static List<Integer> firstNOddNumber(Integer n){
        List<Integer> oddList=new List<Integer>();
        Integer count=0;
        for(Integer i=1;i<2*n;i++){
            if(Math.mod(i,2)==1){
                oddList.add(i);
                count++;
                if(count>=n){
                    break;
                }
            }
        }
        return oddList;
    }
    
    //28.Write a Program to accept a number and print the number in reverse order. 
    //E.g. if 1324 is the number then the output will be 4231.
    public static Integer reverseNumber(Integer num){
        Integer reverseNum=0,lastDigit;
        while(num!=0){
            lastDigit=Math.mod(num,10);
            num/=10;
            reverseNum=reverseNum*10+lastDigit;
        }
        return reverseNum;
    }
    
    //29.Write a Program to accept a number and print sum of it’s digits.
    public static Integer sumOfDigits(Integer num){
        Integer sumOfDigit=0,lastDigit;
        while(num!=0){
            lastDigit=Math.mod(num,10);
            num/=10;
            sumOfDigit+=lastDigit;
        }
        return sumOfDigit;
    }
    
    //30.Write a Program to accept a number and count the number of digits in that number.
    public static Integer countDigit(Integer num){
        Integer numOfDigit=0,lastDigit;
        while(num!=0){
            numOfDigit++;
            num/=10;
        }
        return numOfDigit;
    }
    
    
    //31.Write a program to check whether a given Number is Palindrome or Not
    public static boolean checkPalindrome(Integer num){
        Integer initialNum=num;
        Integer reverseNum=0,lastDigit;
        while(num!=0){
            lastDigit=Math.mod(num,10);
            num/=10;
            reverseNum=reverseNum*10+lastDigit;
        }
        if(initialNum==reverseNum){
            //System.debug('The number is palindrome.');
            return true;
        }
        else{
            //System.debug('The number is not palindrome');
            return false;
        }
    }
    
    //32.Write a program to Check whether a given Number is an Armstrong Number or not. 
    //An Armstrong number is a number that is equal to the sum of its digits, 
    //each raised to the power of the number of digits in the number.
    public static boolean checkArmstrong(Integer num){
        Integer total=0,digit,initialNum,count=0,startingNum;
        initialNum=num;
        startingNum=num;
        while(num!=0){
            num/=10;
            count++;
        }
        while(initialNum!=0){
            digit=Math.mod(initialNum,10);
            total=total+(Integer)Math.pow(digit,count);
            initialNum/=10;
        }
        if(startingNum==total){
            return true;
        }
        else{
            return false;
        }
    }
    
    //33.Write a program to Check Whether given Number is Perfect or Not. 
    //A perfect number is a positive integer that is equal to the sum of its proper divisors, 
    //which are all of its positive divisors excluding the number itself.
    public static boolean perfectNum(Integer num){
        Integer sum=0;
        for(Integer i=1;i<=num/2;i++){
            if(Math.mod(num,i)==0){
                sum+=i;
            }
        }
        if(sum==num){
            return true;
        }
        else{
            return false;
        }
    }
    
    
    //34.Write a program to print table of a given number n.
    public static List<Integer> table(Integer num){
        List<Integer> tableList=new List<Integer>();
        for(Integer i=1;i<=10;i++){
            tableList.add(num*i);
        }
        return tableList;
    }
    
    
    //35.Write a program to print sum of given first n numbers.
    public static Integer sumOfSeries(Integer n){
        Integer total=0;
        for(Integer i=1;i<=n;i++){
            total+=i;
        }
        return total;
    }
    
    
    //36.Write a program to accept a number from user and print it’s factorial.
    public static Integer factorial(Integer n){
        Integer result=1;
        for(Integer i=n;i>0;i--){
            result*=i;
        }
        return result;
    }
    
    
    //37.Write a program to accept a number from the user and print if it is prime or not.
    public static boolean checkPrime(Integer num){
        if(num<2){
            //System.debug('Not prime');
            return false;
        }
        else
        {
            for(Integer i=2;i<=Math.sqrt(num);i++){
                if(Math.mod(num,i)==0){
                    //System.debug('Not prime');
                    return false;
                }
            }  
        }
        //System.debug('Is Prime');
        return true;
    }    
    
    
    //38.Write a program to accept a number and print prime numbers between 2 and n.
    public static List<Integer> rangeOfPrime(Integer n){
        List<Integer> primeList=new List<Integer>();
        for(Integer i=2;i<=n;i++){
            if(checkPrime(i)){
                System.debug(i);
                primeList.add(i);
            }
        }
        return primeList;
    }
    
    
    //39.Write a program to find the Sum of all prime numbers from 1 to n.
    public static Integer sumOfPrime(Integer n){
        Integer sum=0;
        for(Integer i=2;i<=n;i++){
            if(checkPrime(i)){
                sum+=i;
            }
        }
        System.debug(sum);
        return sum;
    }
    
    //40.Write a program to accept a number and print fibonacci series upto that level.
    public static List<Integer> fibonacci(Integer num){
        List<Integer> fiboSeriesList=new List<Integer>();
        Integer firstTerm=0,secondTerm=1;
        Integer fibo;
        Integer count=0;
        System.debug(firstTerm);
        fiboSeriesList.add(firstTerm);
        fiboSeriesList.add(secondTerm);
        System.debug(secondTerm);
        while(count!=num){
            fibo=firstTerm+secondTerm;
            System.debug(fibo);
            fiboSeriesList.add(fibo);
            firstTerm=secondTerm;
            secondTerm=fibo;
            count++;
        }
        return fiboSeriesList;
    }
    
    
    //41.Write a program to accept a number n from the user and Add n terms of the series.
    //1/2! + 2/3! + 3/4! + 4/5! + 5/6! + ………
    
    public static Integer getFactorial(Integer n){
        Integer result=1;
        for(Integer i=n;i>0;i--){
            result*=i;
        }
        return result;
    }
    
    public static Decimal series(Integer n){
        Decimal sum=0;
        for(Integer i=1;i<=n;i++){
            sum=sum+(i/getFactorial(i+1));
        }
        return sum;
    }
    
    
    //42.Write a program to accept a number from user and print that number in words but in reverse order.
    //E.g. 153 -> THREE FIVE ONE
    public static String getWord(Integer num){
        String word;
        switch on num{
            when 0{
                word='Zero';
            }
            when 1{
                word='One';
            }
            when 2{
                word='Two';
            }
            when 3{
                word='Three';
            }
            when 4{
                word='Four';
            }
            when 5{
                word='Five';
            }
            when 6{
                word='Six';
            }
            when 7{
                word='Seven';
            }
            when 8{
                word='Eight';
            }
            when 9{
                word='Nine';
            }
        }
        return word;
    }
    
    public static List<String> printNumber(Integer num){
        List<String> ls=new List<String>();
        String w;
        Integer digit;
        while(num!=0){
            digit=Math.mod(num,10);
            w=getWord(digit);
            ls.add(w);
            num/=10;
        }
        for(Integer i=0;i<ls.size();i++){
            System.debug(ls[i]);
        }
        return ls;
    }
    
    //43.Write a program to create a list of integer numbers and print addition of all the elements of the list.
    public static Integer listOfIntegers(Integer n){
        List<Integer> l=new List<Integer>();
        Integer sum=0;
        for(Integer i=0;i<=n;i++){
            l.add(i);
        }
        for(Integer i=0;i<l.size();i++){
            sum+=l[i];
        }
        System.debug(sum);
        return sum;
    }
    
    //44.Write a program to create a list of integer numbers and print maximum and minimum element from that list.
    public static Integer getMax(List<Integer> l){
        Integer max=l[0];
        for(Integer i=1;i<l.size();i++){
            if(l[i]>max){
                max=l[i];
            }
        }
        return max;
    }
    
    public static Integer getMin(List<Integer> l){
        Integer min=l[0];
        for(Integer i=0;i<l.size();i++){
            if(l[i]<min){
                min=l[i];
            }
        }
        return min;
    }
    
    /*public static void getMaxMin(){
        List<Integer> ls=new List<Integer>{10,20,30,33,55,432};
            System.debug('Maximum:'+getMax(ls));
        System.debug('Minimum:'+getMin(ls));
    }*/
    
    
    //45.Write a program to create a list of integer numbers. Now pick all the even numbers from that list and store them 
    //in evenList. And pick all the odd numbers from that list and store them in oddList.
    
    public static Map<String,List<Integer>> evenOddList(List<Integer> ls){
        List<Integer> oddList=new List<Integer>();
        List<Integer> evenList=new List<Integer>();
        for(Integer i=0;i<ls.size();i++){
            if(Math.mod(ls[i],2)==0){
                evenList.add(ls[i]);
            }
            else{
                oddList.add(ls[i]);
            }
        }
        //System.debug('Odd list:'+oddList);
        //System.debug('Even list:'+evenList);
        Map<String,List<Integer>> mp=new Map<String,List<Integer>>();
        mp.put('Even List',evenList);
        mp.put('Odd List',oddList);
        return mp;
    }
    
    
    //46.Write a program to print day according to the day number entered by the user.   
    public static String getDay(Integer n){
        String day;
        switch on n{
            when 1{
                day='Monday';
            }
            when 2{
                day='Tuesday';
            }
            when 3{
                day='Wednesday';
            }
            when 4{
                day='Thursday';
            }
            when 5{
                day='Friday';
            }
            when 6{
                day='Saturday';
            }
            when 7{
                day='Sunday';
            }
            when else{
                day='Not a valid day';
            }
        }
        return day;
    }
    
    public static String printDay(Integer weekNum){
        System.debug(getDay(weekNum));
        return getDay(weekNum);
    }
    
    //47.Write a program to print the following sequence of integers. 0, 5, 10, 15, 20, 25
    public static List<Integer> printSequence(){
        List<Integer> intList=new List<Integer>();
        for(Integer i=0;i<=25;i+=5){
            //System.debug(i);
            intList.add(i);
        }
        return intList;
    }
    
    
    //48.Write a program to find the Sum of following Series:(1*1) + (2*2) + (3*3) + (4*4) + (5*5) + ... + (n*n)
    public static Integer sumOfSeries1(Integer n){
        Integer sum=0;
        for(Integer i=1;i<=n;i++){
            sum=sum+(i*i);
        }
        System.debug(sum);
        return sum;
    }
    
    
    //49.Write a program to find the Sum of following Series:(1) + (1+2) + (1+2+3) + (1+2+3+4) + ... + (1+2+3+4+...+n)
    public static Integer sumOfSeries2(Integer n){
        Integer sum=0,total=0;
        for(Integer i=1;i<=n;i++){
            sum+=i;
            total+=sum;
        }
        System.debug(total);
        return total;
    }
    
    
    //50.Write a program to find the Sum of following Series:
    //[(1^1)/1!] + [(2^2)/2!] + [(3^3)/3!] + [(4^4)/4!] + [(5^5)/5!] + ... + [(n^n)/n!]
    
    /*public static Integer getFactorial(Integer n){
		Integer result=1;
		for(Integer i=n;i>0;i--){
			result*=i;	
		}
		return result;
	}*/
    
    public static Decimal sumOfSeries3(Integer n){
        Decimal sum=0;
        for(Integer i=1;i<=n;i++){
            sum+=(Math.pow(i,i))/(getFactorial(i));
        }
        System.debug(sum);
        return sum;
    }
    
    //51.Write a program to find sum of even and odd numbers stored in a list.
    public static Map<String,Integer> sumOfEvenOddInList(List<Integer> l){
        Map<String,Integer> mp=new Map<String,Integer>();
        Integer sumOfEven=0,sumOfOdd=0;
        for(Integer i=0;i<l.size();i++){
            if(Math.mod((l[i]),2)==0){
                sumOfEven+=l[i];
            }
            else{
                sumOfOdd+=l[i];
            }
        }
        System.debug('Odd Sum:'+sumOfOdd);
        System.debug('Even Sum:'+sumOfEven);
        mp.put('Odd Sum',sumOfOdd);
        mp.put('Even Sum',sumOfEven);
        return mp;
    }
    
    
    //52.Write a program to Print All the Repeated Numbers with Frequency in a list.
    public static Map<Integer,Integer> repeatedNum(List<Integer> l){
        Map<Integer,Integer> mp=new Map<Integer,Integer>();
        for(Integer i=0;i<l.size();i++){
            if(mp.containsKey(l[i])){
                mp.put(l[i],(mp.get(l[i])+1));
                
            }
            else{
                mp.put(l[i],1);
            }
        }
        
        for(Integer el: mp.keySet()){
            if(mp.get(el)>1){
                System.debug('Repeated number:'+el+' Frequency:'+mp.get(el));
            }
        }
        return mp;
    }
    
    //53.Write a program to Increment Every Element of the List by One & Print Incremented List.
    public static List<Integer> incrementedList(List<Integer> ls){
        for(Integer i=0;i<ls.size();i++){
            ls[i]+=1;
        }
        System.debug(ls);
        return ls;
    }
    
    
    /*54.Jhon has sorted a few confidential numbers in an array (array of int). To ensure that others do not find the numbers 
	easily, he has applied a simple encoding.
	Encoding used: Reverse the original array Each array element has been substituted with a value that is the sum of its 
	original value and its succeeding element’s value.  i.e. arr[i]= original value of arr[i] + original value of arr[i+1] 
	i.e. also note that value of last element i.e. arr[last index] remains unchanged.*/
    
    public static List<Integer> encryption(List<Integer> ls){
        List<Integer> reverse=new List<Integer>();
        List<Integer> encoded=new List<Integer>();
        
        for(Integer i=ls.size()-1;i>=0;i--){
            reverse.add(ls[i]);
        }
        
        for(Integer i=0;i<=reverse.size()-2;i++){
            encoded.add(reverse[i]+reverse[i+1]);
        }
        encoded.add(reverse[reverse.size()-1]);
        System.debug(encoded);
        return encoded;
    }
    
    
    /*55.Jhon Smith has been approached by the “techtomind society for kids” for help in generating the password. 
    After listing the scenario, Smith realises that he will need a programmer’s support. Please help Smith by writing a 
    function to generate the password.
    The scenario is as below-
    N- Numbers are available with the kids. These numbers are either stable or unstable. A number is stable if each of its 
    digits occur the same number of times, i.e. the frequency of each digit in the number is same. For example: 112233, 1111, 
    4004, 12, 1010, 344366, 1010 are stable numbers.
    Similarly, a number is unstable if the frequency of each digit in the number is not the same. For example: 11233, 112, 1223, 101, 343 are unstable numbers.
    The password can be generating as:
    Password=sum of all stable numbers – sum of all unstable numbers
    For example:
    N=5
    Numbers: 12, 1313, 122, 678, 898
    Stable number: 12, 1313, 678    Sum_of_stable= 12+1313+678=2003
    Unstable number: 122, 898        Sum_of_unstable=122+898=1020
    Password= 2003-1020= 983
*/
    public static boolean isStableNum(Integer num){
        Map<Integer,Integer> numFrequency=new Map<Integer,Integer>();
        Integer digit;
        Integer originalNum=num;
        while(num!=0){
            digit=Math.mod(num,10);
            if(numFrequency.containsKey(digit)){
                Integer a=numFrequency.get(digit);
                a+=1;
                numFrequency.put(digit,a);
            }
            else{
                numFrequency.put(digit,1);
            }
            num/=10;
        }
        
        //system.debug(numFrequency);
        Integer firstElement=numFrequency.get(Math.mod(originalNum,10));
        //System.debug(firstElement);
        for(Integer el: numFrequency.keySet()){
            if(numFrequency.get(el)!=firstElement){
                return false;
            }
        }
        return true;
    }
    
    public static Integer password(List<Integer> ls){
        //System.debug(isStableNum(ls[0]));
        List<Integer> stableList =new List<Integer>();
        Integer stableSum=0,unStableSum=0;
        List<Integer> unStableList=new List<Integer>();
        for(Integer i=0;i<ls.size();i++){
            if(isStableNum(ls[i])){
                stableList.add(ls[i]);
            }
            else{
                unStableList.add(ls[i]);
            }
        }
        for(Integer i=0;i<stableList.size();i++){
            stableSum+=stableList[i];
        }
        
        for(Integer i=0;i<unStableList.size();i++){
            unStableSum+=unStableList[i];
        }
        System.debug('Password:'+(stableSum-unStableSum));
        return stableSum-unStableSum;
    }
    
    
    /*56.Write a function which accepts two integer number (Assume that both numbers are >=0) as arguments and adding both 
    * numbers from right to left one digit at a time. You need to calculate and return the total number carries generated 
    * while adding digits of two numbers.   
    Example:  Input: 
    Number1: 675
    Number2: 126
    Output: 2
    Note: 
    5+6= 11 => carry 1      
    7+2+1(carry)  =  10       => carry=1      
    6+1+1(carry)  =  8         => No Carry */
    
    public static Integer countCarry(Integer n1, Integer n2) {
        Integer carry = 0;
        Integer carryCount = 0;
        
        while (n1 > 0 || n2 > 0) {
            Integer digit1 = Math.mod(n1,10); 
            Integer digit2 = Math.mod(n2,10);  
            
            Integer sumDigits = digit1 + digit2 + carry;
            
            if (sumDigits >= 10) {
                carry = 1;  
                carryCount++;
            } else {
                carry = 0; 
            }
            
            n1 = n1 / 10;  
            n2 = n2 / 10;  
        }
        
        return carryCount;
    }
    
    
    /*57.Write program to generate the password which is the sum of all possible palindrome numbers between two numbers.
    For Example:
    Input: 10, 80
    Output: 308
    Explanation:   All palindrome numbers between 10 & 80 are: 11,22,33,44,55,66,77
    Password= 11+22+33+44+55+66+77 = 308*/
        /*public static boolean checkPalindrome(Integer num){
        	Integer initialNum=num;
        	Integer reverseNum=0,lastDigit;
        	while(num!=0){
        		lastDigit=Math.mod(num,10);
        		num/=10;
        		reverseNum=reverseNum*10+lastDigit;
        	}
        	if(initialNum==reverseNum){
        		return true;
        	}
        	else{
        		return false;
        	}
    	}*/
    
    public static Integer password(Integer n1,Integer n2){
        Integer sum=0;
        List<Integer> ls=new List<Integer>();
        for(Integer i=n1;i<=n2;i++){
            if(checkPalindrome(i)){
                ls.add(i);
            }
        }
        for(Integer i=0;i<ls.size();i++){
            sum+=ls[i];
        }
        System.debug(sum);
        return sum;
    }
    
    
    /*58.Tresesco Biswas has been approached by the “techtomind society for kids” for help in generating the password. After 
    listing the scenario, Tresesco realises that he will need a programmer’s support. Please help of Tresesco by writing a 
    function to generate the password.
    The scenario is as below-
    Kids want to generate a password an integer number with K digits. The password is a smallest K-digits number 
    (None of the digits in password is 0) and the product of digits in password is greater than or equal to the sum of 
    digits in password.
    For Examples:
    Input-1:       K=3
    Output-1:    Password= 123
    Input-2:     K=4
    Output-2:  Password = 1124
    Input-3:    K=6
    Output-3:  Password = 111126*/
    public static String getPass(Integer num){
        String str='';
        for(Integer i=0;i<num-2;i++){
            str+='1';           
        }
        System.debug(str+'2'+num);
        return str+'2'+num;
    }
    
    /*59.Write a method, wordReverser(), that will take a given string and reverse the order of the words and append the number 
    of characters of that word at the end of the word. You may assume that the string is a sentence that contains only 
    letters and spaces.
    For examples:
    Input-1 :      "LearNowx rules"
    Outptu-1:    "rules5 LearNowx8"
    Input -2:    "May the Fourth be with you"
    Output-2:   "you3 with4 be2 Fourth6 the3 May3"*/
    
    public static String wordReverser(String sentence) {
        List<String> words = sentence.split(' ');
        List<String> reversedWords = new List<String>();
        for (Integer i = words.size() - 1; i >= 0; i--) {
            String word = words[i];
            reversedWords.add(word + word.length());
        }
        
        String result = String.join(reversedWords, ' ');
        System.debug(result);
        return result;
    }
    
    //60.Create a CountDigitOccurance() method that will take the number and digit as argument and return the number of times 
    //the given digit occurs.
    public static Integer CountDigitOccurance(Integer num,Integer digit){
        Integer d,count=0;
        while(num!=0){
            d=Math.mod(num,10);
            if(d==digit){
                count++;
            }
            num/=10;
        }
        System.debug(count);
        return count;
    }
    
    //61.Create a primeDigits(number) method that will return all the prime digits of an integer number.
    
    /*public static boolean checkPrime(Integer num){
    	if(num<2){
    		//System.debug('Not prime');
    		return false;
    	}
   	 	else
    	{
    		for(Integer i=2;i<=Math.sqrt(num);i++){
    			if(Math.mod(num,i)==0){
    				//System.debug('Not prime');
    				return false;
    			}
    		}  
    	}
    	//System.debug('Is Prime');
    	return true;
    }*/
    
    public static List<Integer> primeDigits(Integer num){
        Integer digit;
        List<Integer> ls=new List<Integer>();
        while(num!=0){
            digit=Math.mod(num,10);
            if(checkPrime(digit)){
                ls.add(digit);
            }
            num/=10;
        }
        System.debug(ls);
        return ls;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}