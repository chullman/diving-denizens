// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("trix")
require("@rails/actiontext")

// prevents attachments on the Trix rich text editor:
// Reference from: https://github.com/basecamp/trix/issues/604 (viewed: 16/07/2022)
document.addEventListener("trix-file-accept", function(event) {
    alert("Sorry, no attachments allowed within the Description field.");
    event.preventDefault();
});

require("@popperjs/core")

// import the bootstrap javascript module
import "bootstrap"

