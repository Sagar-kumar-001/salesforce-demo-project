import { LightningElement,wire,track } from 'lwc';

const columns=[
    {label: "Name", fieldName: "Name"},
    {label: "Account Record Id", fieldName: "Id"},
];
export default class DemoWireComponent extends LightningElement {
    @track columns = columns;
}