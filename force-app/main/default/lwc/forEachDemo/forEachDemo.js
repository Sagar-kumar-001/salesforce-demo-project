import { LightningElement, wire } from 'lwc';
import get10Accounts from '@salesforce/apex/AccountController.get10Accounts'
export default class ForEachDemo extends LightningElement {
    @wire(get10Accounts) accounts;
}