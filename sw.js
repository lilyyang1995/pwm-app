const CACHE_NAME = 'pwm-cache-v1';
const SHELL_FILES = [
  '/',
  '/index.html',
  '/manifest.json',
  '/icon.svg'
];

self.addEventListener('install', (evt) => {
  evt.waitUntil(
    caches.open(CACHE_NAME).then((cache) => cache.addAll(SHELL_FILES))
  );
  self.skipWaiting();
});

self.addEventListener('activate', (evt) => {
  evt.waitUntil(
    caches.keys().then(keys => Promise.all(keys.map(k => {
      if (k !== CACHE_NAME) return caches.delete(k);
    })))
  );
  self.clients.claim();
});

self.addEventListener('fetch', (evt) => {
  const req = evt.request;
  // network first for navigation (index.html), cache-first for others
  if (req.mode === 'navigate' || (req.method === 'GET' && req.headers.get('accept') && req.headers.get('accept').includes('text/html'))) {
    evt.respondWith(
      fetch(req).then(res => { caches.open(CACHE_NAME).then(c=>c.put(req, res.clone())); return res; }).catch(()=>caches.match('/index.html'))
    );
    return;
  }

  evt.respondWith(
    caches.match(req).then(cached => cached || fetch(req).then(netRes => { caches.open(CACHE_NAME).then(c=>c.put(req, netRes.clone())); return netRes; }))
  );
});
