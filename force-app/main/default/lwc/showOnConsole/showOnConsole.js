import { LightningElement,track } from 'lwc';

export default class ShowOnConsole extends LightningElement {
    @track firstName
    @track lastName
    @track email
    @track phone
    @track title

    handleChange(event){


        if(event.target.name=="firstName"){
            this.firstName=event.target.value;
        }
        if(event.target.name=="lastName"){
            this.lastName=event.target.value;
        }
        if(event.target.name=="email"){
            this.email=event.target.value;
        }
        if(event.target.name=="phone"){
            this.phone=event.target.value;
        }
        if(event.target.name=="title"){
            this.title=event.target.value;
        }
    }
    handleClick(){
        console.log(`First Name: ${this.firstName}`);
        console.log(`Last Name: ${this.lastName}`);
        console.log(`Email:${this.email}`);
        console.log(`Phone:${this.phone}`);
        console.log(`Title:${this.title}`);

        // Clear all fields
        this.firstName = '';
        this.lastName = '';
        this.email = '';
        this.phone = '';
        this.title = '';
    }
}