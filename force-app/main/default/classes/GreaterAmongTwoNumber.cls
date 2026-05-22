public class GreaterAmongTwoNumber {
    public static Decimal greaterNumber(Decimal num1,Decimal num2){
        if(num1>num2){
            return num1;
        }
        else if(num2>num1){
            return num2;
        }
        else{
            return 0;
        }
    }
}