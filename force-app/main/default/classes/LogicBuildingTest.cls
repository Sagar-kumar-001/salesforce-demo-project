@isTest
public class LogicBuildingTest {
    public static List<Integer> getList(){
        List<Integer> intList=new List<Integer>();
        for(Integer i=100;i>=0;i--){
            intList.add(i);
        }
		return intList;
    }
    
    public static List<Integer> getList2(){
        List<Integer> intList=new List<Integer>();
        for(Integer i=100;i>0;i-=3){
            intList.add(i);
        }
		return intList;
    }
    
	//18.Test case for print all numbers backwards from 100 to 0
	@isTest
    private static void sequenceTest1(){
        List<Integer> actualList=LogicBuilding.backwardNumSeries();
        List<Integer> expectedList=getList();
        System.assertEquals(expectedList,actualList);
    }
    
    //19.print numbers backwards from 100 to 1 by skipping 2 numbers
    @isTest
    private static void sequenceTestSkipping2(){
        List<Integer> actualList=getList2();
        List<Integer> expectedList=LogicBuilding.backwardSeriesSkip2();
        System.assertEquals(expectedList,actualList);
    }
    
    //20.Write a program to print all the Numbers Divisible by 7 from 1 to 100.
    @isTest
    private static void numbersDivisibleby7Test(){
        List<Integer> expectedNumList=new List<Integer>();
        for(Integer i=1;i<=100;i++){
            if(Math.mod(i,7)==0){
                expectedNumList.add(i);
            }
        }
        List<Integer> actualNumList=LogicBuilding.divisibleBy7();
        System.assertEquals(expectedNumList,actualNumList);
    }
    
    
    //21.Write a Program to print numbers n to 1 using Do While loop.
    @isTest
    private static void printNumberTest(){
        List<Integer> expextedIntList=new List<Integer>();
        Integer n=50;
        while(n>=1){
            expextedIntList.add(n);
            n--;
        }
        List<Integer> actualIntList=LogicBuilding.printSeries(50);
        System.assertEquals(expextedIntList,actualIntList);
    } 
    
    //22.Write a Program to print numbers 1 to n using while loop.
    @isTest
    private static void seriesUsingWhileTest(){
        List<Integer> expectedList=new List<Integer>();
        Integer i=1;
        while(i<=50){
            expectedList.add(i);
            i++;
        }
        List<Integer> actualList=LogicBuilding.seriesUsingWhile(50);
        System.assertEquals(expectedList,actualList);
    }
    
    
    //23.Write a Program to print first n even numbers.
    @isTest
    private static void nEvenNumberTest(){
        List<Integer> expectedList=new List<Integer>();
        Integer count=0;
        for(Integer i=0;i<=2*50;i++){
            if(Math.mod(i,2)==0){
                expectedList.add(i);
                count++;
                if(count>=50){
                    break;
                }
            }
        }
        List<Integer> actualList=LogicBuilding.nEvenNumber(50);
        System.assertEquals(expectedList,actualList);
    }
    
    
    /* 24.Write a function that returns the last digit of the given number. 
    	Last digit is being referred to the least signiﬁcant digit i.e. the digit in the ones (units) place in the given number.
		The last digit should be returned as a positive number. 
		For example, 
		if the given number is 197, the last digit is 7 
		if the given number is -197, the last digit is 7 */
    @isTest
    //Test Case 1,positive number
    private static void getLastDigitTest1(){
        Integer actualNum=7;
    	Integer expectedNum=LogicBuilding.getLastDigit(197);
        System.assertEquals(expectedNum,actualNum);
    }
    
    @isTest
    //Test Case 2,Negative number
    private static void getLastDigitTest2(){
        Integer actualNum=7;
    	Integer expectedNum=LogicBuilding.getLastDigit(-197);
        System.assertEquals(expectedNum,actualNum);
    }
    
    
        /*25. Write a function that returns the second last digit of the given number. Second last digit is being referred to the digit in the tens place in the given number.
		For example,
		if the given number is 197, the second last digit is 9
		Note1 - The second last digit should be returned as a positive number. i.e. if the given number is -197, 
		the second last digit is 9
		Note2 - If the given number is a single digit number, then the second last digit does not exist. 
		In such cases, the function should return -1. i.e. if the given number is 5, the second last digit should be returned as -1
    */
    //Test Case 1
    @isTest
    private static void getSecondLastDigitTest1(){
        Integer expectedNum=9;
        Integer actualNum=LogicBuilding.getSecondLastDigit(197);
        System.assertEquals(expectedNum,actualNum);
    }
    
    //Test Case 2
    @isTest
    private static void getSecondLastDigitTest2(){
        Integer expectedNum=-1;
        Integer actualNum=LogicBuilding.getSecondLastDigit(5);
        System.assertEquals(expectedNum,actualNum);
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
    @isTest
    //Test Case 1 input1=267,input2=154
    private static void addLastDigitsTest1(){
        Integer input1=267,input2=154;
        Integer res=LogicBuilding.addLastDigits(input1,input2);
        System.assertEquals(11,res);
    }
    
    @isTest
    //Test Case 2 input1=267,input2=-154
    private static void addLastDigitsTest2(){
        Integer input1=267,input2=-154;
        Integer res=LogicBuilding.addLastDigits(input1,input2);
        System.assertEquals(11,res);
    }
    
    @isTest
    //Test Case 3 input1=-267,input2=154
    private static void addLastDigitsTest3(){
        Integer input1=-267,input2=154;
        Integer res=LogicBuilding.addLastDigits(input1,input2);
        System.assertEquals(11,res);
    }
    
    @isTest
    //Test Case 4 input1=-267,input2=-154
    private static void addLastDigitsTest4(){
        Integer input1=-267,input2=-154;
        Integer res=LogicBuilding.addLastDigits(input1,input2);
        System.assertEquals(11,res);
    }
    
    //27.Write a Program to print first n odd numbers.
    @isTest
    private static void firstNOddNumberTest(){
        List<Integer> actualList=new List<Integer>{1,3,5,7,9};
        List<Integer> expectedList=LogicBuilding.firstNOddNumber(5);
        System.assertEquals(expectedList,actualList);
    }
    
    //28.Write a Program to accept a number and print the number in reverse order. 
    //E.g. if 1324 is the number then the output will be 4231.
    @isTest
    //Test Case 1
    private static void reverseNumberTest1(){
        Integer actualResult=4231;
        Integer expectedResult=LogicBuilding.reverseNumber(1324);
        System.assertEquals(expectedResult,actualResult);
    }
    
    @isTest
    //Test Case 2
    private static void reverseNumberTest2(){
        Integer actualResult=-987;
        Integer expectedResult=LogicBuilding.reverseNumber(-7890);
        System.assertEquals(expectedResult,actualResult);
    }
    
    //29.Write a Program to accept a number and print sum of it’s digits.
    @isTest
    //Test Case
    private static void sumOfDigitsTest(){
        //Sum of 1+2+3=6
        Integer expectedNum=LogicBuilding.sumOfDigits(123);
        System.assertEquals(expectedNum,6);
    }

    //30.Write a Program to accept a number and count the number of digits in that number.
    @isTest
    //Test Case
    private static void countDigitTest(){
        Integer res=LogicBuilding.countDigit(12345);
        System.assertEquals(5,res);
    }
    
    //31.Write a program to check whether a given Number is Palindrome or Not
    @isTest
    //Test Case 1
    private static void checkPalindromeTest(){
        boolean res=LogicBuilding.checkPalindrome(12321);
        System.assertEquals(true,res);
    }
    
    //Test Case 2
    @isTest
    private static void checkPalindromeTest2(){
        boolean res=LogicBuilding.checkPalindrome(0);
        System.assertEquals(true,res);
    }
    
    //32.Write a program to Check whether a given Number is an Armstrong Number or not. 
    //An Armstrong number is a number that is equal to the sum of its digits, 
    //each raised to the power of the number of digits in the number.
    
    @isTest
    //Test Case 1 
    private static void checkArmstrongTest(){
        Boolean res=LogicBuilding.checkArmstrong(153);
        System.assertEquals(true,res);
    }
    
    @isTest
    //Test Case 2
    private static void checkArmstrongTest2(){
        Boolean res=LogicBuilding.checkArmstrong(121);
        System.assertEquals(false,res);
    }
    
    @isTest
    //Test Case 3
    private static void checkArmstrongTest3(){
        Boolean res=LogicBuilding.checkArmstrong(-153);
        System.assertEquals(true,res);
    }
    
    //33.Write a program to Check Whether given Number is Perfect or Not. 
    //A perfect number is a positive integer that is equal to the sum of its proper divisors, 
    //which are all of its positive divisors excluding the number itself.
    
    @isTest
    //Test case 1
    private static void perfectNumTest(){
        Boolean res=LogicBuilding.perfectNum(6);
        System.assertEquals(true,res);
    }
    
    @isTest
    //Test case 2
    private static void perfectNumTest2(){
        Boolean res=LogicBuilding.perfectNum(10);
        System.assertEquals(false,res);
    }
    
    //34.Write a program to print table of a given number n.
    @isTest
    private static void tableTest(){
        List<Integer> expectedList=LogicBuilding.table(5);
        List<Integer> actualList=new List<Integer>{5,10,15,20,25,30,35,40,45,50};
        System.assertEquals(expectedList,actualList);
    }   
    
    //35.Write a program to print sum of given first n numbers.
    @isTest
    //Series: {1,2,3,4,5}=15
    private static void sumOfSeriesTest(){
        Integer expectedNum=LogicBuilding.sumOfSeries(5);
        System.assertEquals(expectedNum,15);
    }
    
    
    //36.Write a program to accept a number from user and print it’s factorial.
    @isTest
    //Test Case 1
    private static void factorialTest(){
        Integer res=LogicBuilding.factorial(5);
        System.assertEquals(120,res);
    }
    
    @isTest
    //Test Case 2
    private static void factorialTest2(){
        Integer res=LogicBuilding.factorial(0);
        System.assertEquals(1,res);
    }
    
    
    //37.Write a program to accept a number from the user and print if it is prime or not.
    @isTest
    //Test Case 1 
    private static void checkPrimeTest(){
        Boolean res=LogicBuilding.checkPrime(5);
        System.assertEquals(true,res);
    }   
    
    @isTest
    //Test Case 2
    private static void checkPrimeTest2(){
        Boolean res=LogicBuilding.checkPrime(1);
        System.assertEquals(false,res);
    } 
    
    @isTest
    //Test Case 3,edge case 
    private static void checkPrimeTest3(){
        Boolean res=LogicBuilding.checkPrime(2);
        System.assertEquals(true,res);
    } 
    
    //38.Write a program to accept a number and print prime numbers between 2 and n.
    @isTest
    //Test Case 1, n=7
    private static void rangeOfPrimeTest(){
        List<Integer> expectedPrimeList=new List<Integer>{2,3,5,7};
        List<Integer> actualPrimeList=LogicBuilding.rangeOfPrime(7);
        System.assertEquals(expectedPrimeList,actualPrimeList);
    }
    
    @isTest
    //Test Case 1, n=0
    private static void rangeOfPrimeTest2(){
        List<Integer> expectedPrimeList=new List<Integer>{};
        List<Integer> actualPrimeList=LogicBuilding.rangeOfPrime(0);
        System.assertEquals(expectedPrimeList,actualPrimeList);
    }
    
    //39.Write a program to find the Sum of all prime numbers from 1 to n.
    @isTest
    //Test for n=7,ans-17
    private static void sumOfPrimeTest(){
        Integer res=LogicBuilding.sumOfPrime(7);
        System.assertEquals(res,17);
    }
    
    @isTest
    //Test for n=0,ans-0
    private static void sumOfPrimeTest2(){
        Integer res=LogicBuilding.sumOfPrime(0);
        System.assertEquals(res,0);
    }
    
    //40.Write a program to accept a number and print fibonacci series upto that level.
    //Test case 1
    @isTest
    private static void fibonacciTest(){
        List<Integer> expectedList=new List<Integer>{0, 1, 1, 2, 3, 5, 8};
        List<Integer> actualList=LogicBuilding.fibonacci(5);
        System.assertEquals(expectedList,actualList);
    }
    
    //Test case 2
    @isTest
    private static void fibonacciTest2(){
        List<Integer> expectedList=new List<Integer>{0, 1, 1};
        List<Integer> actualList=LogicBuilding.fibonacci(1);
        System.assertEquals(expectedList,actualList);
    }
    
    //41.Write a program to accept a number n from the user and Add n terms of the series.
		//1/2! + 2/3! + 3/4! + 4/5! + 5/6! + ………
	@isTest
    private static void seriesTest(){
        Decimal res=LogicBuilding.series(5);
        System.assertEquals(res,0);
    }
    
    ////42.Write a program to accept a number from user and print that number in words but in reverse order.
    //E.g. 153 -> THREE FIVE ONE
    @isTest
    //Test Case 1
    private static void printNumberTest2(){
        List<String> actualList=new List<String>{'Zero','Nine','Eight','Seven','Six','Five','Four','Three','Two','One'};
        List<String> expectedList=LogicBuilding.printNumber(1234567890);
        System.assertEquals(expectedList,actualList);
    }
    
    @isTest
    //Test Case 2
    private static void printNumberTest3(){
        List<String> actualList=new List<String>{};
        List<String> expectedList=LogicBuilding.printNumber(0);
        System.assertEquals(expectedList,actualList);
    }
    
    //43.Write a program to create a list of integer numbers and print addition of all the elements of the list.
    @isTest
    //Test Case 1, series {0,1,2,3,4,5}=> 15
    private static void listOfIntegersTest(){
        Integer res=LogicBuilding.listOfIntegers(5);
        System.assertEquals(res,15);
    }
    
    @isTest
    //Test Case 2
    //series {0}=>0
    private static void listOfIntegersTest2(){
        Integer res=LogicBuilding.listOfIntegers(0);
        System.assertEquals(res,0);
    }
    
    //44.Write a program to create a list of integer numbers and print maximum and minimum element from that list.
    @isTest
    //Test Case 1
    private static void getMaxTest(){
        Integer res=LogicBuilding.getMax(new List<Integer>{10,2,3,4,50});
        System.assertEquals(res,50);
    }
    
    //Test Case 2
    @isTest
    private static void getMaxTest2(){
        Integer res=LogicBuilding.getMax(new List<Integer>{0,0,0,0,0});
        System.assertEquals(res,0);
    }
    
    //Test Case 3
    @isTest
    private static void getMinTest(){
        Integer res=LogicBuilding.getMin(new List<Integer>{10,23,3,4,5});
        System.assertEquals(res,3);
    }
    
    //Test Case 4
    @isTest
    private static void getMinTest2(){
        Integer res=LogicBuilding.getMin(new List<Integer>{0,0,0,0,0});
        System.assertEquals(res,0);
    }
    
    //45.Write a program to create a list of integer numbers. Now pick all the even numbers from that list and store them 
    //in evenList. And pick all the odd numbers from that list and store them in oddList.
    @isTest
    private static void evenOddListTest(){
        Map<String,List<Integer>> expectedMap=LogicBuilding.evenOddList(new List<Integer>{1,2,3,4,5,6,7});
        System.assertEquals(expectedMap.get('Even List'),new List<Integer>{2,4,6});
        System.assertEquals(expectedMap.get('Odd List'),new List<Integer>{1,3,5,7});
    }
    
    //46.Write a program to print day according to the day number entered by the user.
    @isTest
    //Test Case 1: When week day=1 so Day will be Monday
    private static void printDayTest1(){
        System.assertEquals(LogicBuilding.printDay(1),'Monday');
    }
    
    @isTest
    //Test Case 2: When week day=2 so Day will be Tuesday
    private static void printDayTest2(){
        System.assertEquals(LogicBuilding.printDay(2),'Tuesday');
    }
    
    @isTest
    //Test Case 3: When week day=3 so Day will be Wednesday
    private static void printDayTest3(){
        System.assertEquals(LogicBuilding.printDay(3),'Wednesday');
    }
    
    @isTest
    //Test Case 4: When week day=4 so Day will be Thursday
    private static void printDayTest4(){
        System.assertEquals(LogicBuilding.printDay(4),'Thursday');
    }
    
    @isTest
    //Test Case 5: When week day=5 so Day will be Friday
    private static void printDayTest5(){
        System.assertEquals(LogicBuilding.printDay(5),'Friday');
    }
    
    @isTest
    //Test Case 6: When week day=6 so Day will be Saturday
    private static void printDayTest6(){
        System.assertEquals(LogicBuilding.printDay(6),'Saturday');
    }
    
    @isTest
    //Test Case 7: When week day=7 so Day will be Sunday
    private static void printDayTest7(){
        System.assertEquals(LogicBuilding.printDay(7),'Sunday');
    }
    
    @isTest
    //Test Case 7: When week day=0 so Day will be 'Not a valid day'
    private static void printDayTest8(){
        System.assertEquals(LogicBuilding.printDay(0),'Not a valid day');
    }
    
    //47.Write a program to print the following sequence of integers. 0, 5, 10, 15, 20, 25
    @isTest
    private static void printSequenceTest(){
        List<Integer> actualList=new List<Integer>{0, 5, 10, 15, 20, 25};
        List<Integer> expectedList=LogicBuilding.printSequence();
        System.assertEquals(expectedList,actualList);
    }
    
    //48.Write a program to find the Sum of following Series:(1*1) + (2*2) + (3*3) + (4*4) + (5*5) + ... + (n*n)
    @isTest
    //Test Case 1, n=3, ans should be 14
    private static void sumOfSeries1Test(){
        System.assertEquals(LogicBuilding.sumOfSeries1(3),14);
    }
    
    @isTest
    //Test Case 2, n=1, ans should be 1
    private static void sumOfSeries1Test0(){
        System.assertEquals(LogicBuilding.sumOfSeries1(1),1);
    }
    
    //49.Write a program to find the Sum of following Series:(1) + (1+2) + (1+2+3) + (1+2+3+4) + ... + (1+2+3+4+...+n)
    @isTest
    //Test Case 1,n=3,ans =10
    private static void sumOfSeries2Test(){
        System.assertEquals(LogicBuilding.sumOfSeries2(3),10);
    }
    
    @isTest
    //Test Case 2,n=1,ans =1
    private static void sumOfSeries2Test2(){
        System.assertEquals(LogicBuilding.sumOfSeries2(1),1);
    }
    
    //50.Write a program to find the Sum of following Series:
    //[(1^1)/1!] + [(2^2)/2!] + [(3^3)/3!] + [(4^4)/4!] + [(5^5)/5!] + ... + [(n^n)/n!]
	@isTest
    //Test Case
    private static void sumOfSeries3Test(){
        System.assertEquals(LogicBuilding.sumOfSeries3(3),7.5);
    }
    
    //51.Write a program to find sum of even and odd numbers stored in a list.
    @isTest
    private static void sumOfEvenOddInListTest(){
        Map<String,Integer> mp=LogicBuilding.sumOfEvenOddInList(new List<Integer>{1,2,3,4,5,6,7,8});
        System.assertEquals(mp.get('Even Sum'),20);
        System.assertEquals(mp.get('Odd Sum'),16);
    }
    
    //52.Write a program to Print All the Repeated Numbers with Frequency in a list.
    @isTest
    private static void repeatedNum(){
        Map<Integer,Integer> mp=LogicBuilding.repeatedNum(new List<Integer>{1,1,1,2,2,3,3,3,3});
        System.assertEquals(mp.get(1),3);
        System.assertEquals(mp.get(2),2);
        System.assertEquals(mp.get(3),4);
    }
    
    //53.Write a program to Increment Every Element of the List by One & Print Incremented List.
    @isTest
    private static void incrementedListTest(){
        List<Integer> expectedList=LogicBuilding.incrementedList(new List<Integer>{0,1,2,3,4,5});
        System.assertEquals(expectedList,new List<Integer>{1,2,3,4,5,6});
    }

    /*54.Jhon has sorted a few confidential numbers in an array (array of int). To ensure that others do not find the numbers 
	easily, he has applied a simple encoding.
	Encoding used: Reverse the original array Each array element has been substituted with a value that is the sum of its 
	original value and its succeeding element’s value.  i.e. arr[i]= original value of arr[i] + original value of arr[i+1] 
	i.e. also note that value of last element i.e. arr[last index] remains unchanged.*/
    @isTest
    //Test Case 1
    private static void encryptionTest(){
        List<Integer> expectedList=LogicBuilding.encryption(new List<Integer>{5,1,4,2,3});
        System.assertEquals(expectedList,new List<Integer>{5, 6, 5, 6, 5});
    }
    
    //Q.55
    @isTest
    private static void passwordTest(){
        Integer res=LogicBuilding.password(new List<Integer>{12, 1313, 122, 678, 898});
        System.assertEquals(res,983);
    }
    
    //Q.56
    @isTest
    //Input 675,126, Output=>2
    private static void countCarryTest(){
        System.assertEquals(LogicBuilding.countCarry(675, 126),2);
    }
    
    //Q.57
    @isTest
    //Input 10, 80,result=308
    private static void passwordTest2(){
        Integer res=LogicBuilding.password(10,80);
        System.assertEquals(res,308);
    }
    
    //Q.58
    @isTest
    //Test Case 1
    private static void getPassTest(){
        System.assertEquals(Integer.valueOf(LogicBuilding.getPass(3)),123);
    }
    
    @isTest
    //Test Case 2
    private static void getPassTest2(){
        System.assertEquals(Integer.valueOf(LogicBuilding.getPass(4)),1124);
    }
    
    @isTest
    //Test Case 3
    private static void getPassTest3(){
        System.assertEquals(Integer.valueOf(LogicBuilding.getPass(6)),111126);
    }
    
    //Q.59
    @isTest
    //Test Case 1
    private static void wordReverserTest(){
        System.assertEquals(LogicBuilding.wordReverser('LearNowx rules'),'rules5 LearNowx8');
    }
    
    @isTest
    //Test Case 2
    private static void wordReverserTest2(){
        System.assertEquals(LogicBuilding.wordReverser('May the Fourth be with you'),'you3 with4 be2 Fourth6 the3 May3');
    }
    
    //Q.60
    @isTest
    //Test Case 1
    private static void CountDigitOccuranceTest(){
        System.assertEquals(LogicBuilding.CountDigitOccurance(12123,1),2);
    }
    
    @isTest
    //Test Case 2
    private static void CountDigitOccuranceTest2(){
        System.assertEquals(LogicBuilding.CountDigitOccurance(25252,2),3);
    }
    
    //Q.61
    @isTest
    //Test Case 1
    private static void primeDigitsTest(){
        System.assertEquals(LogicBuilding.primeDigits(123),new List<Integer>{3,2});                    
    }
    
    @isTest
    //Test Case 2
    private static void primeDigitsTest2(){
        System.assertEquals(LogicBuilding.primeDigits(58694),new List<Integer>{5});
    }
    
    
    
}