#!/bin/bash

# Script para comprimir videos antes de subirlos a GitHub
# Uso: ./compress-video.sh input.mp4 [output.mp4]

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verificar que ffmpeg esté instalado
if ! command -v ffmpeg &> /dev/null; then
    echo -e "${RED}❌ Error: ffmpeg no está instalado${NC}"
    echo "Instálalo con: sudo apt install ffmpeg (Linux) o brew install ffmpeg (Mac)"
    exit 1
fi

# Verificar argumentos
if [ $# -eq 0 ]; then
    echo -e "${RED}❌ Error: Debes proporcionar un archivo de entrada${NC}"
    echo "Uso: $0 input.mp4 [output.mp4]"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${2:-${INPUT_FILE%.*}-compressed.mp4}"

# Verificar que el archivo de entrada existe
if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}❌ Error: El archivo '$INPUT_FILE' no existe${NC}"
    exit 1
fi

echo -e "${YELLOW}🎬 Comprimiendo video...${NC}"
echo "📥 Input:  $INPUT_FILE"
echo "📤 Output: $OUTPUT_FILE"
echo ""

# Obtener tamaño del archivo original
ORIGINAL_SIZE=$(du -h "$INPUT_FILE" | cut -f1)
echo "📊 Tamaño original: $ORIGINAL_SIZE"

# Comprimir video
# -vcodec libx264: Codec de video H.264
# -crf 28: Calidad (0-51, donde 28 es buena calidad con compresión)
# -preset veryfast: Velocidad de encoding
# -vf scale: Escalar si es muy grande
# -an: Sin audio (comentá esta línea si querés mantener audio)
ffmpeg -i "$INPUT_FILE" \
    -vcodec libx264 \
    -crf 28 \
    -preset veryfast \
    -vf "scale='min(1920,iw)':'min(1080,ih)':force_original_aspect_ratio=decrease" \
    -movflags +faststart \
    -an \
    "$OUTPUT_FILE" \
    -y

# Verificar resultado
if [ -f "$OUTPUT_FILE" ]; then
    COMPRESSED_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
    echo ""
    echo -e "${GREEN}✅ Video comprimido exitosamente!${NC}"
    echo "📊 Tamaño comprimido: $COMPRESSED_SIZE"
    echo "📁 Ubicación: $OUTPUT_FILE"
    
    # Calcular porcentaje de reducción
    ORIGINAL_BYTES=$(stat -f%z "$INPUT_FILE" 2>/dev/null || stat -c%s "$INPUT_FILE")
    COMPRESSED_BYTES=$(stat -f%z "$OUTPUT_FILE" 2>/dev/null || stat -c%s "$OUTPUT_FILE")
    REDUCTION=$(echo "scale=1; 100 - ($COMPRESSED_BYTES * 100 / $ORIGINAL_BYTES)" | bc)
    echo "📉 Reducción: ${REDUCTION}%"
else
    echo -e "${RED}❌ Error durante la compresión${NC}"
    exit 1
fi
