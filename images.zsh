# Image conversions
function webptopng() { sips -s format png $1.webp --out $1.png }
function pngtowebp() { cwebp $1.png -o $1.webp }
function jpgtowebp() { cwebp $1.jpg -o $1.webp }
function heictojpg() { sips -s format jpeg $1.heic --out $1.jpg }
function heictopng() { sips -s format png $1.heic --out $1.png }
function pngtojpg() { sips -s format jpeg $1.png --out $1.jpg }
function jpgfy() { magick mogrify -monitor -format jpg *.HEIC }

function rmpng() {
  local files=(*.png(N))
  if [[ ${#files[@]} -eq 0 ]]; then
    echo "Nenhum arquivo .png encontrado."
    return 0
  fi
  echo "Arquivos que serao removidos:"
  printf '  %s\n' "${files[@]}"
  echo ""
  rm -f "${files[@]}" && echo "Removidos com sucesso."
}
