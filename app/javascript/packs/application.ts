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
