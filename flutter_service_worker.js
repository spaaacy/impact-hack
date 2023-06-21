'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "abe7f598c26d65244941832b35c49601",
"assets/AssetManifest.smcbin": "30d1e1852e5969c03da5341cd0e77d47",
"assets/assets/images/1.jpg": "c953ac30b888a4f375dcae37095bb7b1",
"assets/assets/images/10.png": "a9748fc6ca047a37a5368ff0cbf43167",
"assets/assets/images/11.png": "12331fe0d3804fa4a7f3800c01df32fd",
"assets/assets/images/12.png": "3bdb805602bbf385d64e8f34ffb9a322",
"assets/assets/images/13.png": "a9ffbdf12232710d2cb14148ce8c0312",
"assets/assets/images/14.png": "07decd5e576b5b06ef0991e353333ce2",
"assets/assets/images/2.jpg": "4f328e819af3d35b4b1a2769baba9361",
"assets/assets/images/3.jpg": "c4142d573000c61cd07a15389324dc41",
"assets/assets/images/39c.jpg": "cd1a0c8bb21bd77a9968bb5563b14021",
"assets/assets/images/4.jpg": "c53a8e3995698c51cafc839ca14d5cd8",
"assets/assets/images/5.jpg": "26d010750bad80c6e7946c7e6f041610",
"assets/assets/images/9.png": "0c2dc8fd741854c31b202f0e7458d58b",
"assets/assets/images/chatgpt-logo.png": "270075c0dc68d155acb39a752ab460c0",
"assets/assets/images/concept.png": "4488df5127d71ffb48818dc7dd473b6b",
"assets/assets/images/cp-bg-1.png": "b4944f9041defa74c40e9570c417472c",
"assets/assets/images/cp-bg-2.png": "f84582210fb143d802146a2027edb501",
"assets/assets/images/hk-skyline.jpg": "f4cb92e4b429491b3f2151ece3e9d669",
"assets/assets/images/hp-bg-1.png": "c2b2848dad84594e3d56784a7bc9bd3b",
"assets/assets/images/juicer-logo.png": "e999aac92f8b3e0f78d25898a1725ba4",
"assets/assets/images/kl-skyline-1.jpg": "632dcc32822641ee40035ecc9d2e347f",
"assets/assets/images/kl-skyline.png": "fd910b7fb44c4bdb5a816a33f853ab84",
"assets/assets/images/lemons-logo.png": "41b0498c71fccdfc60d11b52a2468048",
"assets/assets/images/logo.png": "eff656207e7f89e50c9c8687c6cc66c6",
"assets/assets/images/night-sky.jpg": "952d581455326b837deb50efca938b53",
"assets/assets/images/skyline-detailed.png": "c11402fad28a9dce26e293a9622e8dde",
"assets/assets/images/skyline.png": "9f2dbda4530d2384446aaf7463f4c5e6",
"assets/assets/images/wavey-inverted-1.png": "8311a265dc2174a8368e4d212e10be5d",
"assets/assets/images/wavey-inverted.png": "acaa83c1a6f27cdbc5a9b98c1ee6d17c",
"assets/assets/images/wavey.png": "b5e041d14b6adab1c146144de163156c",
"assets/assets/images/_kl-skyline.jpg": "b1726d6b5f29a792edf84f69187f1f61",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "330099aff37d7b13e310b3784db98347",
"assets/NOTICES": "d8c302e5a9bd53e72d4dace99499d6f3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b91f2096eba328ef5dfba1c66c9e7d9d",
"/": "b91f2096eba328ef5dfba1c66c9e7d9d",
"main.dart.js": "10f8233a64f055b789753e98f8da65e2",
"manifest.json": "30eb15e962fdc338c186e63eacf92a85",
"version.json": "fe9b5b83caf4e847f765278d96288d28"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
