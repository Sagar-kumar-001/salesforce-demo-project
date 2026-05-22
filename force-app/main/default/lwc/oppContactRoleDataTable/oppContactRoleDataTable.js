import { LightningElement, api, track,wire } from 'lwc';
import getContactRoles from '@salesforce/apex/getOppContactRoles.getContactRoles';
columns = [
    { label: 'Contact Name', fieldName: "ContactId" },
    { label: 'Role', fieldName: 'Role' },
    // { label: 'Phone', fieldName: 'contactPhone' }
];

export default class OppContactRoleDataTable extends LightningElement {
    @api recordId;
    @track data = [];
    @track columns = columns;
    
    @wire(getContactRoles,{oppId: this.recordId})
    wiredOppContactRoles({error, data}){
        if(data){
            this.data=data;
        } else if(error) {
            console.error(error);
        }
    }
    // connectedCallback() {
    //     getContactRoles({ oppId: this.recordId })
    //         .then((result) => {
    //             this.data = result.map(item => ({
    //                 Id: item.Id,
    //                 Role: item.Role,
    //                 contactName: item.Contact?.Name,
    //                 contactPhone: item.Contact?.Phone
    //             }));
    //         })
    //         .catch(error => {
    //             console.error('Error fetching contact roles:', error);
    //         });
    // }
}