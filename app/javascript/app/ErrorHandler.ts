import * as Sentry from '@sentry/browser';
import { GetConfig } from './Config';

export function InitializeErrorHandler() {
    const sentryDsn = GetConfig("sentry_dsn");
    if (!sentryDsn) {
        return;
    }
    const isSampled = Boolean(GetConfig("is_sampled"));
    Sentry.init({
        dsn: sentryDsn,
        autoSessionTracking: true,
        tracesSampler: () => isSampled,
        integrations: [
            new Sentry.BrowserTracing()
        ]
    });
}
