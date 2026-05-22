@isTest
public class PositiveNegativeOrZeroTest {
	//Test Case 1,Positive Number
	@isTest
    private static void positiveTest(){
        String res=PositiveNegativeOrZero.checkNumber(5);
        System.assertEquals('Positive',res);
    }
    
    //Test Case 2,Negative Number
	@isTest
    private static void negativeTest(){
        String res=PositiveNegativeOrZero.checkNumber(-5);
        System.assertEquals('Negative',res);
    }
    
    //Test Case 3,Zero
	@isTest
    private static void zeroTest(){
        String res=PositiveNegativeOrZero.checkNumber(0);
        System.assertEquals('Zero',res);
    }
    

}