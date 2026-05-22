@isTest
public class AreaOfTriangleTest {
	@isTest
    public static void test1(){
        //Test case 1 Normal Base = 5 And Height = 10 (0.5*5*10=25)
        Decimal result=AreaOfTriangle.areaOfTriangle(5,10);
        System.assertEquals(25,result);
    }
    
    //Test case 2(Edge case) Base=0 And Height=10 (0.5*0*10=0)
    @isTest
    private static void test2(){
        Decimal result=AreaOfTriangle.areaOfTriangle(0,10);
        System.assertEquals(0,result);
    }
    
    //Test case 3 Base=0.3 And Height=10.5 (0.5*0.3*10.5=1.575)
    @isTest
    private static void test3(){
        Decimal result=AreaOfTriangle.areaOfTriangle(0.3,10.5);
        System.assertEquals(1.575,result);
    }
}