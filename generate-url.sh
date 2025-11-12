#!/bin/bash

# Generador de URLs de jsDelivr
# Uso: ./generate-url.sh <usuario> <repositorio> <rama> <ruta-archivo>
# Ejemplo: ./generate-url.sh santiagochinellato landing-assets main public/videos/video-home.mp4

set -e

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

# Función de ayuda
show_help() {
    echo "🔗 Generador de URLs de jsDelivr para GitHub"
    echo ""
    echo "Uso:"
    echo "  $0 <usuario> <repositorio> <rama> <ruta-archivo>"
    echo ""
    echo "Ejemplo:"
    echo "  $0 santiagochinellato landing-assets main public/videos/video-home.mp4"
    echo ""
    echo "Argumentos:"
    echo "  usuario      - Tu usuario de GitHub"
    echo "  repositorio  - Nombre del repositorio"
    echo "  rama         - Rama (generalmente 'main' o 'master')"
    echo "  ruta-archivo - Ruta completa del archivo desde la raíz del repo"
}

# Verificar argumentos
if [ $# -eq 0 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_help
    exit 0
fi

if [ $# -ne 4 ]; then
    echo -e "${RED}❌ Error: Número incorrecto de argumentos${NC}"
    echo ""
    show_help
    exit 1
fi

USER="$1"
REPO="$2"
BRANCH="$3"
FILE_PATH="$4"

# Limpiar la ruta del archivo (quitar / al inicio si existe)
FILE_PATH="${FILE_PATH#/}"

# Generar URL
JSDELIVR_URL="https://cdn.jsdelivr.net/gh/${USER}/${REPO}@${BRANCH}/${FILE_PATH}"
GITHUB_RAW_URL="https://raw.githubusercontent.com/${USER}/${REPO}/${BRANCH}/${FILE_PATH}"

echo ""
echo -e "${GREEN}✅ URLs generadas:${NC}"
echo ""
echo -e "${CYAN}📦 jsDelivr (CDN - Recomendado):${NC}"
echo "$JSDELIVR_URL"
echo ""
echo -e "${YELLOW}🐙 GitHub Raw (Directo):${NC}"
echo "$GITHUB_RAW_URL"
echo ""
echo -e "${CYAN}💡 Tip:${NC} Probá la URL en el navegador para verificar que funciona"
echo ""

# Verificar si curl está disponible para hacer un test
if command -v curl &> /dev/null; then
    echo -e "${YELLOW}🔍 Verificando disponibilidad...${NC}"
    
    # Test jsDelivr
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$JSDELIVR_URL")
    if [ "$HTTP_CODE" == "200" ]; then
        echo -e "${GREEN}✅ jsDelivr: Archivo disponible (HTTP $HTTP_CODE)${NC}"
    else
        echo -e "${RED}❌ jsDelivr: No disponible aún (HTTP $HTTP_CODE)${NC}"
        echo "   ⏳ Esperá 30-60 segundos si recién subiste el archivo"
    fi
fi

echo ""
