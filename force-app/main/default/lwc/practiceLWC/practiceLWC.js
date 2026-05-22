import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/PracticeClass.getContactList';
import findContact from '@salesforce/apex/PracticeClass.findContact';
const columns = [
    { label : 'Id' , fieldName : 'Id'},
    { label : 'Name', fieldName : 'Name'},
    { label : 'Account', fieldName : 'AccountId'},
    { label : 'Active', fieldName : 'thebrokerup__Active__c'},
];
export default class PracticeLWC extends LightningElement {
    contacts;
    searchKey;
    contact;
    columns = columns;
    // @wire(getContactList)
    // wiredData(result){
    //     if(result.data){
    //         this.contacts = result.data;
    //         console.log('this.contacts',this.contacts);
    //     } else if(result.error){
    //         console.log('----',error);
    //     }
    // }

    @wire(findContact,{searchKey : '$searchKey'})
    wiredContact(result){
        if(result.data){
            this.contact=JSON.stringify(result.data);
            this.contacts=result.data;
        }
        else if(result.error){
            console.log(error);
        }
    }


    handleChange(event){
        this.searchKey = event.target.value;
        // console.log('this.searchKey---',this.searchKey);
    }
}