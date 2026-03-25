import { createServerClient } from '@supabase/ssr'
import { NextResponse, type NextRequest } from 'next/server'

export async function middleware(request: NextRequest) {
  let supabaseResponse = NextResponse.next({ request })

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() { return request.cookies.getAll() },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) =>
            request.cookies.set(name, value)
          )
          supabaseResponse = NextResponse.next({ request })
          cookiesToSet.forEach(({ name, value, options }) =>
            supabaseResponse.cookies.set(name, value, options)
          )
        },
      },
    }
  )

  const { data: { user } } = await supabase.auth.getUser()

  const { pathname } = request.nextUrl

  // Route pubbliche — nessun redirect
  const publicRoutes = [
    '/',
    '/login',
    '/register',
    '/reset-password',
    '/update-password',
    '/privacy',
    '/cookie-policy',
    '/termini',
  ]

  const isPublicRoute = publicRoutes.includes(pathname)
  const isWebhook = pathname.startsWith('/api/webhooks/')
  const isSign = pathname.startsWith('/sign/')
  const isPortal = pathname.startsWith('/portal/')
  const isNextInternal = pathname.startsWith('/_next/')

  if (!user && !isPublicRoute && !isWebhook && !isSign && !isPortal && !isNextInternal) {
    const redirectUrl = request.nextUrl.clone()
    redirectUrl.pathname = '/login'
    return NextResponse.redirect(redirectUrl)
  }

  return supabaseResponse
}

export const config = {
  matcher: ['/((?!_next/static|_next/image|favicon.ico|public).*)'],
}
