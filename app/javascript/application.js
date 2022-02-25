import "./controllers"
import "@hotwired/turbo-rails"
import "@fortawesome/fontawesome-free/css/all"
import { Application } from "@hotwired/stimulus"

const application = Application.start()

 //= require_tree
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
