import { LightningElement,api } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import assignContactToClientContact from '@salesforce/apex/ContactController.assignContactToClientContact';
const actions=[
    {label:'Assign',name:'assign'},
    {label:'View',name:'view'},
    {label:'Delete',name:'delete'},
]
const columns=[
    {label:'Name',fieldName:'Name'},
    {label:'Email',fieldName:'Email'},
    {label:'Phone',fieldName:'Phone'},
    {
        type:'action',
        typeAttributes:{rowActions:actions},
    }
]

export default class DataTableWithRowActionNavigationAndCreation extends LightningElement {
    data=[];
    columns=columns;
    @api recordId;

    connectedCallback(){
        getContacts({accId:this.recordId})
        .then(result=>{
            // console.log('result'+JSON.stringify(result));
            this.data=result;
        })
        .catch(error=>{
            console.log(error);
            console.log("Error Error");
        })    
    }

    handleRowAction(event){
        const actionName=event.detail.action.name;
        const rowData=event.detail.row;
        if(actionName == 'assign'){
            console.log('assign');
            this.assignContact(this.recordId,rowData.Id);
            
        }
        else if(actionName == 'view'){
            console.log('view');
        }
        else if(actionName == 'delete'){
            console.log('delete');
        }
    }

    assignContact(acId,contId){
        console.log(acId);
        console.log(contId);
        assignContactToClientContact({accId:acId,contactId:contId})
        .then(result=>{
            console.log('result'+result);
        })
        .catch(error=>{
            console.log(error);
            console.log("Error Error");
        })
    }            
}