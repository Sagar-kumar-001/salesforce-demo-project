import { LightningElement, track,wire } from 'lwc';
import getOpList from '@salesforce/apex/GetOppList.getOpList';
const columns=[
    {label:'Opportunity Name', fieldName:'Name'},
    //{label:'Stage', fieldName:'StageName'},
    //{label:'Amount', fieldName:'Amount'},
    {label:'AccountId', fieldName:'AccountId'},
    {label:'Close Date', fieldName:'CloseDate'},
    {label:'Account Name',fieldName:'AccountName'},
]
export default class OppList extends LightningElement {
    @track data=[];
    @track columns=columns;
    // @wire(getOpList)
    // wiredOppList({data,error}){
    //     if(data){
    //         this.data=data.map(record=>{
    //             return{
    //                 //Id:record.Id,
    //                 Name:record.Name,
    //                 //StageName:record.StageName,
    //                 //Amount:record.Amount,
    //                 AccountId:record.AccountId,
    //                 CloseDate:record.CloseDate,
    //                 AccountName:record.Account?.Name,
    //             }
    //         });
    //     } else if(error) {
    //         console.error(error);
    //     }    
    // }
    connectedCallback(){
        getOpList()
        .then(result=>{
            this.data=result.map(record=>{
                return {
                    Name:record.Name,
                    AccountId:record.AccountId,
                    CloseDate:record.CloseDate,
                    AccountName:record.Account?.Name,
                }
            });
        })
        .catch(error=>{
            console.log(error);
        })
    }
}