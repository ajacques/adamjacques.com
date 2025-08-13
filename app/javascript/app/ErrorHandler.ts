import { init as sentryInit } from '@sentry/browser';
import { GetConfig } from './Config';

export function InitializeErrorHandler() {
    const sentryDsn = GetConfig("sentry_dsn");
    if (!sentryDsn) {
        return;
    }
    const isSampled = Boolean(GetConfig("is_sampled"));
    sentryInit({
        dsn: sentryDsn,
        tracesSampler: () => isSampled
    });
}
