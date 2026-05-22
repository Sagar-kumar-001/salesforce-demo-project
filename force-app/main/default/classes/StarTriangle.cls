public class StarTriangle {
    public static void traingle(){
        for(Integer i=0;i<5;i++){
            String a='';
            for(Integer j=0;j<=i;j++){
                a=a+'*';
            }
            System.debug(a);
        }
    }
}