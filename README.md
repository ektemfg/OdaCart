# OdaCart
Temaoppgave - Tema 7

Committa og pusha en gang etter 24.10.2022 23:59 grunnet en filstruktur feil som gjorde at prosjektet ikke kunne bygges.
Det var slikt at ContentView lå i View groupen/folderen. Da er det ikke mulig å bygge, heller ikke å se noe i file tree.
Nå er det ordna.

I tillegg ble ikke Info.plist som sier at SplashScreen skal være asseten splashIcon tatt med siste commit -> push så jeg pushet den opp også i etterkant, slik at appen kan bygge og kjøre når dere ser gjennom den.
Ellers fikk jeg en feilmelding om at prosjektet ikke finner OdaCard/info.plist ved bygging etter at jeg clonet prosjektet herfra.

Hva fikk jeg til av det oppgaven spurte om?

✅ The application supports all screen resolutions and both landscape/portrait orientations ✅

✅ Minimal supported iOS version set to 15.0 ✅

Only few things to fix to make it 14.0 + compatible 

-> AsyncImage and 'data(for:delegate:) ARE NOT COMPATIBLE WITH IOS 14.

if #available(iOS 15.0, *) returns false we must have a fallback function
which uses compatible method.

Error handling & loading state handling: 
Stil TODO - Did not prioritize this because we save data on first fetch and load it from UserDefaults.

✅ Clicking on Product Icon Shows Image Fullscreen ✅

I did choose to make LargeItemView with Large Product Image and Product info such as Name, Extra Name and Price.

✅ The shopping cart panel visible only if there are items in cart. ✅

✅ Discounted products show discounted price, and old price ✅

✅ Shopping Cart shows updated Total Price and Item Count when adding/removing to cart + Saved to UserDefaults ✅

✅ The app maintains the state of the shopping cart between launches. ✅

⛔️TODO: Add Triangle at top left corner as overlay on Product Image if on Sale stating Salg! with Yellow Background⛔️

ALWAYS MORE TO DO, AND I WOULD LIKE TO MAKE MY CODE EVEN TIDIER AND EVEN EASIER TO READ.
But anyways, I am very happy with the result, and look forward to make it even better.

Dimitrije :)
