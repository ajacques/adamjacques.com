import { GetConfig } from "./Config";

declare global {
    interface Window {
        _paq: Array<Array<String>> | undefined
    }
}

export function RegisterMetrics() {
    const url = GetConfig("beacon_url");
    const id = GetConfig("beacon_site_id");
    if (!url || !id) {
        return;
    }
    window._paq = [];
    window._paq.push(["setTrackerUrl", url + "matomo.php"]);
    window._paq.push(["setSiteId", id]);
    window._paq.push(["trackPageView"]);
    window._paq.push(["enableLinkTracking"]);
    const head = document.getElementsByTagName("head")[0];
    const element = document.createElement("script");
    element.async = true;
    element.src = url + "matomo.js";
    head.appendChild(element);
}
