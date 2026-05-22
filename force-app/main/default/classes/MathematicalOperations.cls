public class MathematicalOperations {
    public static Decimal operator(Decimal num1, Decimal num2, String operator){
        Switch on operator{
            when '+'{
            	return num1+num2;
        	}
            
            when '-'{
                return num1-num2;
            }
            
            when '*'{
                return num1*num2;
            }
            
            when '/'{
                return num1/num2;
            }
            when else{
                return 0;
            }
        }   	
    }
}