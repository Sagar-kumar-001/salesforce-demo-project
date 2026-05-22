import { LightningElement ,api} from 'lwc';
import getContactPhones from '@salesforce/apex/OpportunityContactService.getContactPhones';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CopyContactsPhone extends LightningElement {

    @api recordId;
    @api invoke(){
        this.handleCopyPhones();    
        
    }
    handleCopyPhones(){
        getContactPhones({oppId:this.recordId})
            .then(phones=>{
                if(phones.length>0){
                    const phoneList=phones.join(',');
                    this.copyTextToClipboard(phoneList);
                    this.ShowToast('Success', 'Phone numbers copied to clipboard', 'success');
                }
                else{
                    this.ShowToast('Warning', 'No phone numbers found', 'warning');
                }
            })
            .catch(error=>{
                this.ShowToast('Error', error.message, 'error');
            });
    }
    copyTextToClipboard(text){
        navigator.clipboard.writeText(text);
    }   

    ShowToast(title,message,variant){
        this.dispatchEvent(new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        }));
    }
}