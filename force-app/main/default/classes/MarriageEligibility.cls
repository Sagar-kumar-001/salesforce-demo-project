public class MarriageEligibility {
    public static String checkEligibility(String maritalStatus, String gender, Integer age){
        if(maritalStatus!='married'){
            if(gender=='female' && age>18){
                return 'Eligible for marriage';
            }
            else if(age>21){
                return 'Eligible for marriage';
            }
            else{
                return 'Not Eligible for marriage';
            }
        }
        else{
            return 'Not Eligible for marriage';
        }
    }
}