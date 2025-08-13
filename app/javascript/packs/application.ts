import { InitializeErrorHandler } from '../app/ErrorHandler';
import VideoHandler from '../ui/VideoHandler';
import { RegisterMetrics } from "../app/Matomo";
import '../../assets/stylesheets/application.css'
import { captureException } from '@sentry/browser';

function InitializeApp() {
  InitializeErrorHandler();
  try {
    VideoHandler();
    RegisterMetrics();
  } catch (e) {
    captureException(e);
  }
}

if (document.readyState === 'interactive') {
  window.setTimeout(InitializeApp, 200);
} else {
  document.addEventListener('DOMContentLoaded', InitializeApp);
}
