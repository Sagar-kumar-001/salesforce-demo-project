@isTest
public class SwapTest {
    //Normal values
	@isTest
    private static void test1(){
        Integer a=10,b=20;
        Swap.swapping(a,b);
        System.assertEquals(20,a);
        System.assertEquals(10,b);
    }
}