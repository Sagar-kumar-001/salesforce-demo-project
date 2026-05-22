@isTest
public class NumberIsEvenTest {
	//Test case 1
	@isTest
    private static void evenTest(){
        Integer res=NumberIsEven.checkNum(4);
        System.assertEquals(2,res);
    }
    
    //Test case 2
    @isTest
    private static void oddTest(){
        Integer res=NumberIsEven.checkNum(3);
        System.assertEquals(1,res);
    }
    
    //Test case 3,edge case
    @isTest
    private static void test(){
        Integer res=NumberIsEven.checkNum(2);
        System.assertEquals(2,res);
    }
}