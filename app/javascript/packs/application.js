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

require('packs/jquery-3.2.1')
require('packs/jquery.form')
require('packs/jquery.validate.min')
require('packs/bootstrap.min')
require('packs/coming-soon')
require('packs/gmaps')
require('packs/main')
require('packs/plugins')
require('packs/pryce')
