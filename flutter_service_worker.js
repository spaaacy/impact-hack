'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "d778d8b1f42d0dd1bb284e5ca9549187",
".git/config": "1411c0e60676c82d6c1bc23e1aeb7231",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "30de7af4e3589f7ed7d21edc508b60b0",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "346a522a8b3a158f4ff1106bb72f013a",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "1da5aead101ba3f814898a250680bade",
".git/logs/refs/heads/github-pages": "26e754feb5e9d925bdab0fde5096c8c5",
".git/logs/refs/heads/master": "aefe2b70f27f49fc186fe2f69f436fff",
".git/logs/refs/remotes/origin/github-pages": "29b0ee09ba9f097bd740525df0326f57",
".git/objects/03/c531a7a4eadfbb97e5434401927ee31890cf33": "fe6b24f60048b7f218835d95c2c650ae",
".git/objects/06/4ca803c6b250fee7b88918b285150f7f5d9b72": "71eae0095c3f98114c4513ef2ee3293f",
".git/objects/0b/85bcdb86bf9e9f9fda81b13cec9c9349d47d77": "77cbf4b6cc88e2471afd14a98ef2e0ed",
".git/objects/0d/16ac9f6bdb452d80ca57792c91c554ecb009d5": "29560817bfc96c88c35a3149b85ea798",
".git/objects/12/28753bf246147fa228c497b979e4a13d8e0988": "2b7218fb19f5855826167b43669ec8be",
".git/objects/17/bdb7606db561643ff0d69dd8fdd49cc11a73b7": "6060678c307ffc33f788f1e20a8f7157",
".git/objects/18/2bd5017e7981091b5ce2433a80221234846989": "a9b310b46793db18bd2fe69a0f0caedb",
".git/objects/18/84fad52a55f31ed458bf357fd986d235cd4a3d": "4c4d4d1889a8f838745ca2832d9b815b",
".git/objects/1b/52a732301efba8abd49b121b936ee7cb0ecf83": "9b41d4586792c2fa6aef9a5f7d64a3fc",
".git/objects/1d/384f3748038966a5c7316223edf120dd5894dd": "a8d542276aa823dfefb8d26439e1077a",
".git/objects/1e/bf993c04c08e17a0122730f8d7ce6e139c8bad": "eeb4f0d71f24758335fe1753273ad6c2",
".git/objects/1f/686edd1465272558af328ca43cb7189a0059e6": "5e83820f6d3e5392693d45bc239b2b61",
".git/objects/23/3b3f38823f2353d954d85d25828a6556e80c94": "961a4b24eb005522811d118e06a62168",
".git/objects/27/36fe12e8f917fef44b22dd4aea8c53e4d034c3": "f2fbcd561f7d6617e5889153e011d5e9",
".git/objects/28/616c52256aea9c57e61def26acb9d881e87949": "85dae0a52a75a8159a099842dced0f2b",
".git/objects/2e/f8436cfeee4c25bdc01bcc6c9cf1ee2385680f": "683e38279b4d8a01168398428f8a2a1f",
".git/objects/35/91af41948adc8001f3586d76b91181311953fc": "c91d33b29071dcff3b2b3385383761cb",
".git/objects/35/e783e92eed376be49118c16dc8f217be3876f1": "88326213c4bd6d1b57eff4da1e8c2a71",
".git/objects/37/7580cbf691d03aea79c63a3a251b1b48ac01f1": "c196d282a50e3c372b4445c6b8868297",
".git/objects/3d/bbe72961005a05bbbda85a7138fc02db883775": "c01a5ce44c23c30bfb77c92d1fc30406",
".git/objects/3f/3790a32b44711c3931340da10cc39b5d94a939": "54c9dcb2c2e32d6d4000dcf860c50d01",
".git/objects/40/c1be57fa1d0ff4f94de381085e836d8595b16b": "d67fe50a4505a54916a6432d1a31d8bf",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/48/3f3b6506c33c7dcc5de9b5ea732dd041b0a5f6": "8b10469816933462ae4c04580693c041",
".git/objects/48/fc225e6fb26d3d6ecab1c900a771b5b12bfcf3": "8432b2a3426db82709cbca29c81e6e85",
".git/objects/51/34e6402246228fb7f58ce8fe76727a61d99a62": "6b5e5b48febe40daec7062aecdc3b39f",
".git/objects/56/d39da429b466a43ca326762e6935fad668424a": "3310e4023c00db6808931bfb331b3800",
".git/objects/5a/58340f40e80897f37291730b136084555035b7": "0696ffb800e5cf3948eed21b39e28b57",
".git/objects/62/a01d6826913d9efa140d2e9f4bc0f13918e607": "44ba2af6a4f05cb190463143170ae010",
".git/objects/63/0cab50cd50589bdaaecf029e74b68dacbdd47a": "7dd7aeadde2e40de807c6c256132c9fc",
".git/objects/66/83eaf001a6795fe10050933f980a1771d04af5": "6f3fd609ab5d1f5f7d41f61949c9dbd8",
".git/objects/69/b896b3b49f4ccc9fbfbf22d139187695329195": "6603a7d0cc360f066267732dd2e1b56c",
".git/objects/6c/7123b51191471d3ade1a03318a6ef676367932": "68abf2e496b35ce9ce609830e5290275",
".git/objects/70/010cc4761157d9d7cc2d082cf342e63fe1190a": "baf21d1dacab382149ee93266543ff40",
".git/objects/71/e96055e2846fc87b2722494fc0f7b815dd88e1": "cfab14ecae44c3d71ccd507a7c67fb01",
".git/objects/72/906aa8c6b1b96a2f5d5e90c34cf10189c93078": "e6d538beaac3fd8d9593e2375c98ea7b",
".git/objects/74/fbb43f1bda3a332759e9b116e8392f82596105": "0775162aca1ec8c716c7abfbe4aa2da3",
".git/objects/76/3b8decf33de38a44773300b523c8c527963ace": "3bd7754f38591433a7ea68c4e46a8acb",
".git/objects/76/6f06eca96d08684c3ab7c181b9ea3b4f099938": "0ba585b46a8487424efe4865124b76dd",
".git/objects/7e/6fccaf15bd2d4bc1284acd7445eb1251eefd47": "fb3e81c27354baec4e596da661893db6",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8a/b79cf34432466d1c0e0b3c3ccaf05cd7c4bbc2": "cefd1d3aa7e7979b88e5ebdb7d866dac",
".git/objects/8e/7f4b338840099949781ab85496d7a67fae46f1": "7f2803c236e9e7d95ef6ed16a3a2bd13",
".git/objects/95/cbc70ad62235950379c3c45f9df79f8b10aa9a": "e4d2df1230023c0fe93d3c16fc03ff3a",
".git/objects/a0/1f538b1a27499b5fae902f8d203333599251ce": "8562c2d33ff5cf2e9a2b287eab63c990",
".git/objects/a4/82fe5f6f58da39f21936fab746cee55a8b56f6": "c4bc13a14fe6018a31b94aaccb5e6bc0",
".git/objects/ae/37803d1933c3979fd1b939ff61cc667b0b70dc": "f5c08c98e82ebd9034dbd78b64a292fa",
".git/objects/ae/9c5a658d64eaf993f2d61ff4294c6fafce7fdd": "7180d70405defe73ab5ca20e33ff5842",
".git/objects/b2/2fdb2d1fa6a3bced274617d58f6ab432bb0d8b": "1b405e4dfab487f51d41422d52600614",
".git/objects/b2/fe4b8c0338f018d60c24aa56bee9320d3169fb": "320d2206af6244a8db03e515606a6bfe",
".git/objects/b5/bf07bb8d344aeb9a859fa1b3dfdfa18c11c7a8": "e6dd1dcf4ec017309c4c010ee508ded8",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b8/a2e3d0c6d7bb7608a8d1acbde61b56f17305b8": "28e03326c37d9dbb9d3250aa18ed6a66",
".git/objects/b8/da762e97b74db62e4fbbc6581b9d667fa2b4c1": "e90b1d6f14dac54fb873684b4e2b31dd",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/bb/ac29f5ef7a40bf14c0901bc1457724156bc0de": "1393f20f0610cabefe2d4f45865b0f54",
".git/objects/c2/a714ecd3d01a70369f9cb07bb4ea9d96263286": "d06d883fb5e750372d635f0e9a8118c9",
".git/objects/c4/a168ebe50caa27a701ea1bb0a7c1de72289d25": "ec2dd8f1845ef9637fdc97afb318deaf",
".git/objects/cf/9fd6e9e5f42117ff157a36297125749ede1623": "d75b4a7b205d3fcef3f4662a188426b9",
".git/objects/d1/9f9b8d69b55ab58a5fb5a53ff4fe04c703c334": "5699f519416dc5875279c83f7c851e59",
".git/objects/d3/efa7fd80d9d345a1ad0aaa2e690c38f65f4d4e": "610858a6464fa97567f7cce3b11d9508",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/db/20d59545077e8df7f65c81323b008b9940df33": "956eff8c1fc677b49728ff296417890e",
".git/objects/e6/6990288114cc3f7b359018a90087f4cae8a676": "32983249bef666a9ea3f0ed2221b6f42",
".git/objects/e7/5e920f175da53dd6f04d858636baa25dc702f4": "0fd694d0b7477cee41611e70d0cd6732",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/eb/d860a84459bfd4249d0a3b091c6d0a8b8f0716": "e6072d3f9e4a8c0b6614c1ee18afe99b",
".git/objects/f2/921c7a76e86c873d1a266e07eae820bce6810a": "c8228d5e8442c5d2d20a12246889d2b0",
".git/refs/heads/github-pages": "888c6a55fdeb37a168180b47f3f23c80",
".git/refs/heads/master": "888c6a55fdeb37a168180b47f3f23c80",
".git/refs/remotes/origin/github-pages": "888c6a55fdeb37a168180b47f3f23c80",
"assets/AssetManifest.json": "abe7f598c26d65244941832b35c49601",
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
"index.html": "1acbb638878fa4e5e56d7cc99e0122e5",
"/": "1acbb638878fa4e5e56d7cc99e0122e5",
"main.dart.js": "8fb3a8a1c80fb33f819de6ed9e2d5912",
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
