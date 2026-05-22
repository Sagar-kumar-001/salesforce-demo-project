@isTest
public class NumIsOddTest {
	//Test case 1
	@isTest
    private static void evenTest(){
        Integer res=NumIsOdd.checkNum(4);
        System.assertEquals(1,res);
    }
    
    //Test case 2
    @isTest
    private static void oddTest(){
        Integer res=NumIsOdd.checkNum(3);
        System.assertEquals(2,res);
    }
    
    //Test case 3,edge case
    @isTest
    private static void test(){
        Integer res=NumIsOdd.checkNum(2);
        System.assertEquals(1,res);
    }
}