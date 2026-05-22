@isTest
public class SumTest {
	@isTest
    private static void sumTesting1(){
        Decimal ans=Sum.returningSum(10,20);
        System.assertEquals(30,ans);
    }
    
    @isTest
    private static void sumTesting2(){
        Decimal ans=Sum.returningSum(-10,20);
        System.assertEquals(-10,ans);
    }
}