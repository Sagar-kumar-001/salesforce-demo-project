@isTest
public class NumberGreaterEqualOrLessThan10Test {

    //Test case 1
    @isTest
    private static void greaterTest(){
        String res=NumberGreaterEqualOrLessThan10.check(11);
        System.assertEquals('Number is greater than 10',res);
    }
    
    //Test case 2
    @isTest
    private static void lesserTest(){
        String res=NumberGreaterEqualOrLessThan10.check(9);
        System.assertEquals('Number is less than 10',res);
    }
    
    //Test case 3
    @isTest
    private static void equalTest(){
        String res=NumberGreaterEqualOrLessThan10.check(10);
        System.assertEquals('Number is equal to 10',res);
    }
}