@isTest
public class AreaOfCircleTest {
	@isTest
    private static void areaTest(){
        Decimal result=AreaOfCircle.areaOfCircle(5);
        System.assertEquals(78.550,result);
    }
    @isTest
    private static void areaTest2(){
        Decimal result=AreaOfCircle.areaOfCircle(-5);
        System.assertEquals(78.550,result);
    }
}