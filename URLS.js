// 🔗 URLs de jsDelivr para usar en tu código
// ============================================

// Para tu componente VideoHome en React:

const videoData = {
  id: 1,
  alt: "Laboratorios Katz",
  urlHorizontal: "https://cdn.jsdelivr.net/gh/santiagochinellato/landing-assets@main/public/videos/horizontal.mp4",
  urlVertical: "https://cdn.jsdelivr.net/gh/santiagochinellato/landing-assets@main/public/videos/vertical.mp4",
};

// Ejemplo de uso con ReactPlayer:

/*
<ReactPlayer
  url={videoData.urlVertical}
  playing={true}
  muted={true}
  loop={true}
  controls={false}
  width="100%"
  height="100%"
  playsinline={true}
/>
*/

// 📝 Notas importantes:
// 
// 1. Las URLs usan el formato:
//    https://cdn.jsdelivr.net/gh/<usuario>/<repo>@<rama>/<ruta>
//
// 2. El @main es importante - indica la rama del repo
//
// 3. jsDelivr cachea los archivos automáticamente
//    - Primera vez: puede tardar 1-2 minutos
//    - Luego: súper rápido desde CDN global
//
// 4. Si actualizás un video con el mismo nombre:
//    - Hacer commit y push a GitHub
//    - Esperar 5-10 minutos para que se actualice el caché
//    - O usar versionado: vertical-v2.mp4, etc.
//
// 5. Para purgar caché manualmente (raramente necesario):
//    https://www.jsdelivr.com/tools/purge

export default videoData;
