import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "myInput" ]

  alertText() {
    const element = this.myInputTarget
    const myInput = element.value
    alert(`My ${myInput}`)
  }
}
