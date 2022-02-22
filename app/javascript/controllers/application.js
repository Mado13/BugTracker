import { Application } from "@hotwired/stimulus"
import "@fortawesome/fontawesome-free/js/all";
import "@fortawesome/fontawesome-free/css/all";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
