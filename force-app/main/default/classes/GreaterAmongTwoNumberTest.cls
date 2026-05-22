@isTest
public class GreaterAmongTwoNumberTest {
    static Decimal num1=10,num2=20;
	//Test Case 1 num2>num1
	@isTest
    private static void test1(){
        Decimal res=GreaterAmongTwoNumber.greaterNumber(num1, num2);
        System.assertEquals(num2,res);
    }
    
    //Test Case 2 
	@isTest
    private static void test2(){
        Decimal res=GreaterAmongTwoNumber.greaterNumber(num2, num1);
        System.assertEquals(num2,res);
    }
    
    //Test Case 3
	@isTest
    private static void test3(){
        Decimal res=GreaterAmongTwoNumber.greaterNumber(10,10);
        System.assertEquals(0,res);
    }
}