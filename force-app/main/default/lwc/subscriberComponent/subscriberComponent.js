import { LightningElement,wire,api,track } from 'lwc';
import myMessageChannel from '@salesforce/messageChannel/myMessageChannel__c';
import { MessageContext,subscribe, unsubscribe} from 'lightning/messageService';
import getRelatedContacts from '@salesforce/apex/AccountController.getRelatedContacts';
export default class SubscriberComponent extends LightningElement {
    @api Id=''
    @track contacts=[];
    subscription=null;
    @wire(MessageContext) messageContext;
    connectedCallback(){
        if(!this.subscription){
            this.subscription=subscribe(this.messageContext,myMessageChannel,(message)=>{ 
                this.Id=message.Id;
        });
        }
    }
    disconnectedCallback(){
        if(this.subscription){
            unsubscribe(this.subscription);
            this.subscription=null;
        }
    }

    @wire(getRelatedContacts,{accId: '$Id'}) 
    wiredContacts({error,data}){
        if(data){
            this.contacts=data;
        }
        else if(error){
            console.log(error);
        }
    }

}