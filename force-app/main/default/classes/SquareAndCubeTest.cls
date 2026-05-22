@isTest
public class SquareAndCubeTest {
    
    //Test Case-1, Normal values num=5, result=25
	@isTest
    private static void squareTest1(){
        Decimal result=SquareAndCube.getSquare(5);
        System.assertEquals(25,result);
    }
    
    //Test Case-2, decimal values num=2.4, result=5.76
	@isTest
    private static void squarTest2(){
        Decimal result=SquareAndCube.getSquare(2.4);
        System.assertEquals(5.76,result);
    }
    
    //Test Case-3, normal values num=2, result=8
	@isTest
    private static void cubeTest1(){
        Decimal result=SquareAndCube.getCube(2);
        System.assertEquals(8,result);
    }
    
    //Test Case-4, decimal values num=2.4, result=13.824
	@isTest
    private static void cubeTest2(){
        Decimal result=SquareAndCube.getCube(2.4);
        System.assertEquals(13.824,result);
    }
    
}