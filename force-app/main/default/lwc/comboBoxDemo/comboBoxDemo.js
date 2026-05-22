import { LightningElement, track,wire } from 'lwc';
import get10Accounts from '@salesforce/apex/AccountController.get10Accounts';
import getContacts from '@salesforce/apex/ContactController.getContacts';
const columns=[
    {label:'Contact Name',fieldName:'Name'},
    {label:'Phone',fieldName:'Phone'},
    {label:'Email',fieldName:'Email'},
]
export default class ComboBoxDemo extends LightningElement {
    columns=columns;
    @track value='';
    @track options=[];
    @track data=[];
    showtable = false;
    connectedCallback(){
        get10Accounts()
            .then(result => {
                // Create new array with mapped account data
                this.options = result.map(account => {
                    return {
                        label: account.Name,
                        value: account.Id
                    };
                });
            })
            .catch(error => {
                console.log('error--->', error);
            });
        
    }
    handleChange(event){
        this.value=event.detail.value;
        getContacts({accId:this.value})
            .then(result=>{
                console.log(result);
                this.showtable = true
                this.data=result;
            })
            .catch(error=>{
                console.log('error--->', error);
            });
    }

    
    // @wire(getContacts,{accId:this.value})
    // contacts({data,error}){
    //     if(data){
    //         this.data=data;
    //     }
    //     if(error){
    //         console.log('error--->', error);
    //     }
    // }
    
}