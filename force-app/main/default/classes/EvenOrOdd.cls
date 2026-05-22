public class EvenOrOdd {
    public static String checkEvenOdd(Integer num){
        if(Math.mod(num,2)==0){
            return 'Even';
        }
        else{
           	return 'Odd';
        }
    }
}