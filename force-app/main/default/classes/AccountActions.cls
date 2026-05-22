public class AccountActions {
    public static void updateAccount(List<Account> accList){
        for(Account acc:accList){
            acc.Rating='Hot';
        }
    }
}