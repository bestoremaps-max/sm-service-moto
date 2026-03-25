'use client'
import { useState, useEffect } from 'react'

type ConsentState = {
  necessary: true
  analytics: boolean
  marketing: boolean
}

export function CookieBanner() {
  const [visible, setVisible] = useState(false)
  const [showDetail, setShowDetail] = useState(false)
  const [consent, setConsent] = useState<ConsentState>({
    necessary: true,
    analytics: false,
    marketing: false,
  })

  useEffect(() => {
    const saved = localStorage.getItem('cookie_consent')
    if (!saved) setVisible(true)
  }, [])

  const save = (c: ConsentState) => {
    localStorage.setItem('cookie_consent', JSON.stringify({
      ...c,
      timestamp: new Date().toISOString(),
    }))
    setVisible(false)
  }

  const acceptAll = () => save({ necessary: true, analytics: true, marketing: true })
  const rejectAll = () => save({ necessary: true, analytics: false, marketing: false })
  const saveCustom = () => save(consent)

  if (!visible) return null

  return (
    <div className="fixed bottom-0 left-0 right-0 z-50 p-4 bg-white border-t border-gray-200 shadow-lg">
      <div className="max-w-4xl mx-auto">
        {!showDetail ? (
          <div className="flex flex-col sm:flex-row items-start sm:items-center gap-4">
            <p className="text-sm text-gray-600 flex-1">
              Utilizziamo cookie per migliorare la tua esperienza.
              Leggi la nostra <a href="/cookie-policy" className="text-brand underline">Cookie Policy</a>.
            </p>
            <div className="flex gap-2 flex-shrink-0">
              <button onClick={() => setShowDetail(true)}
                className="px-3 py-1.5 text-sm border border-gray-300 rounded-lg hover:bg-gray-50">
                Personalizza
              </button>
              <button onClick={rejectAll}
                className="px-3 py-1.5 text-sm border border-gray-300 rounded-lg hover:bg-gray-50">
                Solo necessari
              </button>
              <button onClick={acceptAll}
                className="px-3 py-1.5 text-sm bg-brand text-white rounded-lg hover:bg-brand-dark">
                Accetta tutti
              </button>
            </div>
          </div>
        ) : (
          <div className="space-y-3">
            <h3 className="font-semibold text-gray-900">Preferenze cookie</h3>
            <div className="space-y-2">
              <label className="flex items-center gap-3">
                <input type="checkbox" checked disabled className="w-4 h-4" />
                <span className="text-sm"><strong>Necessari</strong> — sempre attivi</span>
              </label>
              <label className="flex items-center gap-3">
                <input type="checkbox" checked={consent.analytics}
                  onChange={e => setConsent(p => ({ ...p, analytics: e.target.checked }))}
                  className="w-4 h-4" />
                <span className="text-sm"><strong>Analitici</strong> — PostHog per statistiche uso</span>
              </label>
              <label className="flex items-center gap-3">
                <input type="checkbox" checked={consent.marketing}
                  onChange={e => setConsent(p => ({ ...p, marketing: e.target.checked }))}
                  className="w-4 h-4" />
                <span className="text-sm"><strong>Marketing</strong> — non utilizzati al momento</span>
              </label>
            </div>
            <div className="flex gap-2">
              <button onClick={saveCustom}
                className="px-3 py-1.5 text-sm bg-brand text-white rounded-lg hover:bg-brand-dark">
                Salva preferenze
              </button>
              <button onClick={() => setShowDetail(false)}
                className="px-3 py-1.5 text-sm border border-gray-300 rounded-lg hover:bg-gray-50">
                Indietro
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
