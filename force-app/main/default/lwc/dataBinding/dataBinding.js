import { LightningElement ,track} from 'lwc';

export default class DataBinding extends LightningElement {
    @track greeting="Sagar"
    handleClick(){
        this.greeting=this.template.querySelector('lightning-input').value;
    }
}