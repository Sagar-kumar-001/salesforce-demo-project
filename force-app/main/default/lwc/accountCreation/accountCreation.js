import { LightningElement,wire } from 'lwc';
import addAccount from '@salesforce/apex/AccountController.addAccount';
export default class AccountCreation extends LightningElement {

    accountName;
    phone;
    website;
    annualRevenue;
    billingCity;
    handleChange(event) {
        if(event.target.label === "Account Name") {
            this.accountName = event.target.value;
        } else if(event.target.label === "Phone") {
            this.phone = event.target.value;
        } else if(event.target.label === "Website") {
            this.website = event.target.value;
        } else if(event.target.label === "Annual Revenue") {
            this.annualRevenue = event.target.value;
        } else if(event.target.label === "Billing City") {
            this.billingCity = event.target.value;
        }
    }

    handleClick(event) {
        addAccount({
            accountName: this.accountName,
            phone: this.phone,
            website: this.website,
            annualRevenue: this.annualRevenue,
            billingCity: this.billingCity});
        
        this.accountName = '';
        this.phone = '';
        this.website = '';
        this.annualRevenue = '';
        this.billingCity = '';    
    }    
}