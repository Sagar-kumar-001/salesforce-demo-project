public class NumberGreaterEqualOrLessThan10 {
    public static String check(Decimal num){
        if(num>10){
            return 'Number is greater than 10';
        }
        else if(num==10){
            return 'Number is equal to 10';
        }
        else{
            return 'Number is less than 10';
        }
    }
}