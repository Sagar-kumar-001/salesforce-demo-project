@isTest
public class SimpleInterestTest {
    //Test Case 1,Simple values p=1000,r=10,t=5 (1000*10*5/100=500)
    @isTest
    public static void test1(){
        Decimal result=SimpleInterest.getSimpleInterest(1000,10,5);
        System.assertEquals(500,result);
    }
    
    //Test Case 2, Decimal values p=1000, r=7.5, t=5 (1000*7.5*5=375)
    @isTest
    private static void test2(){
        Decimal result=SimpleInterest.getSimpleInterest(1000,7.5,5);
        System.assertEquals(375,result);
    }
    
    //Test Case 3, Edge case p=0,r=10,t=5 (0*10*5=0)
    @isTest
    private static void test3(){
        Decimal result=SimpleInterest.getSimpleInterest(0,10,5);
        System.assertEquals(0,result);
    }
}