public class PositiveNegativeOrZero {
    Public static String checkNumber(Decimal num){
        if(num==0){
            return 'Zero';
        }
        else if(num<0){
            return 'Negative';
        }
        else{
            return 'Positive';
        }
    }
}