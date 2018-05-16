import { Controller } from "stimulus"
import Sortable from "sortablejs"
import { Socket } from "phoenix"

export default class extends Controller {
  initialize() {
    this.initSortableElements()

    const socket = new Socket("/socket", {params: {token: window.userToken}})
    socket.connect()
    this.channel = socket.channel("room:lobby", {})

    // const messageContainer = document.querySelector("#messages")

    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    // this.channel.on("new_msg", payload => {
    //   let messageItem = document.createElement("li")
    //   messageItem.innerText = `[${Date()}] ${payload.body}`
    //   messageContainer.appendChild(messageItem)
    // })

    this.channel.on("make_editable", payload => {
      if(payload.user != window.userToken) {
        const contentId = document.getElementById(payload.body)

        contentId.style.pointerEvents = "none"
        contentId.style.filter = "blur(5px)"
      }
    })

    this.channel.on("set_content", payload => {
      if(payload.user != window.userToken) {
        const contentId = document.getElementById(payload.elementId)

        contentId.innerText = payload.body
      }
    })

    this.channel.on("unblur_editable", payload => {
      if(payload.user != window.userToken) {
        const contentId = document.getElementById(payload.body)

        contentId.style.pointerEvents = "all"
        contentId.style.filter = "none"
      }
    })

    this.channel.on("change_color", payload => {
      if(payload.user != window.userToken) {
        const contentId = document.getElementById(payload.elementId)

        contentId.style.backgroundColor = payload.body
      }
    })

    this.channel.on("blur_sort", payload => {
      if(payload.user != window.userToken) {
        console.log("ok")
        const element = document.getElementById(payload.body)

        element.style.pointerEvents = "none"
        element.style.filter = "blur(5px)"
      }
    })

    this.channel.on("unblur_sort", payload => {
      if(payload.user != window.userToken) {
        const item = document.getElementById(payload.body.item)

        // const parentElement = document.getElementById(payload.body.to)
        // parentElement.appendChild(item)
        
        const siblingElement = document.getElementById(payload.body.to_children[0])
        // change where it is inserted so it goes after the panel container id
        siblingElement.insertAdjacentElement("afterEnd", item)
        
        item.style.pointerEvents = "all"
        item.style.filter = "none"
      }
    })
  }

  makeEditable(event) {
    const target = event.currentTarget

    target.setAttribute("contenteditable", "true")

    this.channel.push("make_editable", {body: target.id, user: window.userToken})
  }

  submitData(event) {
    const target = event.currentTarget

    this.updateContent(target.id, target.textContent)
    target.setAttribute("contenteditable", "false")

    this.channel.push("set_content", {body: target.innerText, elementId: target.id, user: window.userToken})
    this.channel.push("unblur_editable", {body: target.id, user: window.userToken})
  }

  changeColor(event) {
    const color = getComputedStyle(event.target).getPropertyValue("background-color")
    const panelDiv = event.currentTarget.parentElement.nextElementSibling.nextElementSibling

    this.updateColor(color, panelDiv)

    const parentDiv = panelDiv.previousElementSibling.previousElementSibling.parentElement
    parentDiv.style.backgroundColor = color

    this.channel.push("change_color", {body: color, elementId: parentDiv.id, user: window.userToken})
  }

  // handleChatInput(event) {
  //   const target = event.currentTarget

  //   if(event.keyCode === 13){
  //     this.channel.push("new_msg", {body: target.value})
  //     target.value = ""
  //   }
  // }

  handleEvent(event) {
    const target = event.currentTarget

    // target.style.pointerEvents = "none"
    // target.style.filter = "blur(5px)"
  }

  //Private Methods

  initSortableElements() {
    const pageEl = document.getElementById("page")
    Sortable.create(
      pageEl,
      {
        group: "boards",
        onStart: (event) => {
          this.channel.push("blur_sort", {body: event.item.id})
        },
        onEnd: (event) => {
          this.updateOrder(event)
          this.unBlurSort(event)
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
            onStart: (event) => {
              this.channel.push("blur_sort", {body: event.item.id})
            },
            onEnd: (event) => {
              this.updateOrder(event)
              this.unBlurSort(event)
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
            onStart: (event) => {
              this.channel.push("blur_sort", {body: event.item.id})
            },
            onEnd: (event) => {
              this.updateOrder(event)
              this.unBlurSort(event)
            }
          }
        );
      }
    }
  }

  // sendEvent(event) {
  //   fetch("/api/event", {
  //     method: "POST",
  //     headers: new Headers({
  //       "Content-Type": "application/json",
  //     }),
  //     body: JSON.stringify({
  //       event: event
  //     })
  //   })
  // }

  unBlurSort(sortEvent) {
    const payload = {
      item: sortEvent.item.id,
      to: sortEvent.to.id,
      from: sortEvent.from.id,
      to_children: Array.from(sortEvent.to.children).map((div)=>{return div.lastElementChild.id}),
      from_children: Array.from(sortEvent.from.children).map((div)=>{return div.lastElementChild.id})
    }

    this.channel.push("unblur_sort", {body: payload, user: window.userToken})
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
