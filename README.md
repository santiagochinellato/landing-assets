# Landing Assets 🎬

Repositorio para alojar assets (videos, imágenes, etc.) para el proyecto Landing de Laboratorios Katz.

## 📁 Estructura

```
/public/
  /videos/
    vertical.mp4       # Video principal vertical (móviles)
    horizontal.mp4     # Video principal horizontal (desktop)
```

## 🔗 URLs de jsDelivr

Una vez subido a GitHub, los archivos estarán disponibles vía CDN:

```
https://cdn.jsdelivr.net/gh/santiagochinellato/landing-assets@main/public/videos/vertical.mp4
https://cdn.jsdelivr.net/gh/santiagochinellato/landing-assets@main/public/videos/horizontal.mp4
```

## 🚀 Uso en React

```javascript
const videoData = {
  id: 1,
  alt: "Laboratorios Katz",
  urlHorizontal: "https://cdn.jsdelivr.net/gh/santiagochinellato/landing-assets@main/public/videos/horizontal.mp4",
  urlVertical: "https://cdn.jsdelivr.net/gh/santiagochinellato/landing-assets@main/public/videos/vertical.mp4",
};
```

## 📝 Notas

- **Repositorio público**: Necesario para que jsDelivr pueda servir los archivos
- **Límite de tamaño**: Archivos hasta ~100 MB (recomendado < 50 MB)
- **Caché**: jsDelivr cachea los archivos, puede tardar 1-2 minutos en actualizar

## 🧰 Scripts incluidos

- `compress-video.sh`: Comprimir videos con ffmpeg
- `generate-url.sh`: Generar URLs de jsDelivr automáticamente
