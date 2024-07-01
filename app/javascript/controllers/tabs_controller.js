import { Controller } from "@hotwired/stimulus"

const classes = ["text-blue-600", "hover:text-blue-600", "border-blue-600", "border-b-2"]

export default class extends Controller {
  static targets = ["btn", "tab"]
  static values = { defaultTab: String }

  connect() {
    this.tabTargets.map(x => x.hidden = true)

    try {
      let selectedBtn = this.btnTargets.find(element => element.id === this.defaultTabValue)
      let selectedTab = this.tabTargets.find(element => element.id === this.defaultTabValue)
      selectedTab.hidden = false
      selectedBtn.classList.add(...classes)
    } catch { }
  }

  select(event) {
    let selectedTab = this.tabTargets.find(element => element.id === event.currentTarget.id)
    this.tabTargets.map(x => x.hidden = true)
    this.btnTargets.map(x => x.classList.remove(...classes))
    selectedTab.hidden = false
    event.currentTarget.classList.add(...classes)
  }
}
