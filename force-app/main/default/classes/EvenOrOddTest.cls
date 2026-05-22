@isTest
public class EvenOrOddTest {
	@isTest
    private static void evenTest(){
        String res=EvenOrOdd.checkEvenOdd(6);
        System.assertEquals('Even',res);
    }
    
    @isTest
    private static void oddTest(){
        String res=EvenOrOdd.checkEvenOdd(5);
        System.assertEquals('Odd',res);
    }
    
    @isTest
    private static void evenTest2(){
        String res=EvenOrOdd.checkEvenOdd(-6);
        System.assertEquals('Even',res);
    }
}