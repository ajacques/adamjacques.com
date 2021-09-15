// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import { InitializeErrorHandler } from '../app/ErrorHandler';
import VideoHandler from '../ui/VideoHandler';
import {RegisterMetrics} from "../app/Matomo";

function InitializeApp() {
  InitializeErrorHandler();
  VideoHandler();
  RegisterMetrics();
}

if (document.readyState === 'interactive') {
  window.setTimeout(InitializeApp, 200);
} else {
  document.addEventListener('DOMContentLoaded', InitializeApp);
}
