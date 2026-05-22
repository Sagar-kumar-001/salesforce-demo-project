import { LightningElement ,track,api} from 'lwc';

export default class TrackAndAPIDecoratorDemo extends LightningElement {
    @api recordId
    @track message="Hello Sagar"

}