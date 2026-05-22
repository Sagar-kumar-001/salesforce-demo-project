@isTest
public class MathematicalOperationsTest {
	Static Decimal a=20,b=10;
    //Test Case 1 addition 
    @isTest
    private static void additionTest(){
        Decimal res=MathematicalOperations.operator(a,b,'+');
        System.assertEquals(30,res);
    }
    
    //Test Case 2 subtraction
    @isTest
    private static void subtractionTest(){
        Decimal res=MathematicalOperations.operator(a,b,'-');
        System.assertEquals(10,res);
    }
    
    //Test Case 3 multiplication
    @isTest
    private static void multiplicationTest(){
        Decimal res=MathematicalOperations.operator(a,b,'*');
        System.assertEquals(200,res);
    }
    
    //Test Case 4 Division
    @isTest
    private static void divisionTest(){
        Decimal res=MathematicalOperations.operator(a,b,'/');
        System.assertEquals(2,res);
    }
    
    //Test Case 4 Division
    @isTest
    private static void Test1(){
        Decimal res=MathematicalOperations.operator(a,b,'^');
        System.assertEquals(0,res);
    }
}