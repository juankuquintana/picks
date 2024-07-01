# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from 'app/javascript/packs', under: 'packs'
pin '@rails/activestorage', to: 'activestorage.esm.js'
pin '@rails/request.js', to: 'https://ga.jspm.io/npm:@rails/request.js@0.0.9/src/index.js'
pin '@sentry/browser', to: 'https://cdn.jsdelivr.net/npm/@sentry/browser@7.109.0/esm/index.js'
pin '@sentry-internal/feedback', to: 'https://cdn.jsdelivr.net/npm/@sentry-internal/feedback@7.109.0/esm/index.js'
pin '@sentry-internal/replay-canvas', to: 'https://cdn.jsdelivr.net/npm/@sentry-internal/replay-canvas@7.109.0/esm/index.js'
pin '@sentry-internal/tracing', to: 'https://cdn.jsdelivr.net/npm/@sentry-internal/tracing@7.109.0/esm/index.js'
pin '@sentry/core', to: 'https://cdn.jsdelivr.net/npm/@sentry/core@7.109.0/esm/index.js'
pin '@sentry/replay', to: 'https://cdn.jsdelivr.net/npm/@sentry/replay@7.109.0/esm/index.js'
pin '@sentry/utils', to: 'https://cdn.jsdelivr.net/npm/@sentry/utils@7.109.0/esm/index.js'
