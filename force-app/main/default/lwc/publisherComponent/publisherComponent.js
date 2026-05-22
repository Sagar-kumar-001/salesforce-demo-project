import { LightningElement,api,track,wire } from 'lwc';
import getAccounts  from '@salesforce/apex/AccountController.getAccounts';
import myMessageChannel from '@salesforce/messageChannel/myMessageChannel__c';
import { MessageContext,publish } from 'lightning/messageService';
import Id from '@salesforce/user/Id';
export default class PublisherComponent extends LightningElement {
    @track accountOptions=[];
    @api selectedAccountId;
    userId = Id;
    @wire (getAccounts) 
    wiredAccounts({error,data}){
        if(data){
            this.accountOptions=data.map(account=>({label:account.Name, value:account.Id}));
        }
        else if(error){
            console.log(error);
        }
    }

    handleChange(event){
        this.selectedAccountId=event.detail.value;
        console.log(this.selectedAccountId);
    }

    @wire(MessageContext) messageContext;
    handleClick(){
        let payload={Id:this.selectedAccountId};
        publish(this.messageContext,myMessageChannel,payload);
    }

}