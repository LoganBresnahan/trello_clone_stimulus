import { Controller } from "stimulus"
import Sortable from "sortablejs"
import { Socket } from "phoenix"

export default class extends Controller {
  initialize() {
    this.initSortableElements()
    const socket = new Socket("/socket", {params: {token: window.userToken}})
    socket.connect()
    this.channel = socket.channel("room:lobby", {})
    // let chatInput = document.querySelector("#chat-input")
    const messageContainer = document.querySelector("#messages")

    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    this.channel.on("new_msg", payload => {
      let messageItem = document.createElement("li")
      messageItem.innerText = `[${Date()}] ${payload.body}`
      messageContainer.appendChild(messageItem)
    })
  }

  makeEditable(event) {
    const target = event.currentTarget

    target.setAttribute("contenteditable", "true")
  }

  submitData(event) {
    const target = event.currentTarget

    this.updateContent(target.id, target.textContent)
    target.setAttribute("contenteditable", "false")
  }

  changeColor(event) {
    const color = getComputedStyle(event.target).getPropertyValue("background-color")
    const panelDiv = event.currentTarget.parentElement.nextElementSibling.nextElementSibling

    this.updateColor(color, panelDiv)
    panelDiv.previousElementSibling.previousElementSibling.parentElement.style.backgroundColor = color
  }

  handleChatInput(event) {
    console.log(event)
    if(event.keyCode === 13){
      this.channel.push("new_msg", {body: event.currentTarget.value})
      event.currentTarget.value = ""
    }
  }

  //Private Methods

  initSortableElements() {
    const pageEl = document.getElementById("page")
    Sortable.create(
      pageEl,
      {
        group: "boards",
        onEnd: (event) => {
          this.updateOrder(event)
        }
      }
    )

    const boards = document.getElementsByClassName("page-items")
    for(let pageCount = 0; pageCount < boards.length; pageCount++){
      for(let boardCount = 0; boardCount < boards[pageCount].children.length; boardCount++){
        let boardEl = document.getElementById(`${boards[pageCount].children[boardCount].lastElementChild.id}`)
        Sortable.create(
          boardEl,
          {
            group: "lanes",
            onEnd: (event) => {
              this.updateOrder(event)
            }
          }
        );
      }
    }

    const boardItems = document.getElementsByClassName("board-items") //getting all boards
    for(let boardItemsCount = 0; boardItemsCount < boardItems.length; boardItemsCount++){ //how many boards on the page
      for(let laneCount = 0; laneCount < boardItems[boardItemsCount].children.length; laneCount++){ //how many lanes on the page
        let el = document.getElementById(`${boardItems[boardItemsCount].children[laneCount].lastElementChild.id}`) //for each lane on the page get the lane id from the inner div
        Sortable.create(
          el,
          {
            group: "panels",
            onEnd: (event) => {
              this.updateOrder(event)
            }
          }
        );
      }
    }
  }

  updateOrder(sortEvent) {
    fetch("/api/order_event", {
      method: "POST",
      headers: new Headers({
        'Content-Type': 'application/json',
      }),
      body: JSON.stringify({
        to: sortEvent.to.id,
        to_children: Array.from(sortEvent.to.children).map((div)=>{return div.lastElementChild.id}),
        from_children: Array.from(sortEvent.from.children).map((div)=>{return div.lastElementChild.id}),
      }),
    })
  }

  updateColor(color, panelDiv) {
    fetch("/api/color_event", {
      method: "POST",
      headers: new Headers({
        'Content-Type': 'application/json',
      }),
      body: JSON.stringify({
        color: color,
        model_info: panelDiv.id,
      })
    })
  }

  updateContent(modelInfo, content) {
    fetch("/api/content_event", {
      method: "POST",
      headers: new Headers({
        'Content-Type': 'application/json',
      }),
      body: JSON.stringify({
        model_info: modelInfo,
        content: content,
      })
    })
  }
}

// export default socket
