#!/usr/bin/env bash
# Downloads all Figma asset references for the cotiweb home page
# into assets/img/. Figma asset URLs expire ~7 days after generation,
# so re-run get_design_context if these stop working.
#
# Usage:  bash download-assets.sh

set -e
cd "$(dirname "$0")"
mkdir -p assets/img
cd assets/img

BASE="https://www.figma.com/api/mcp/asset"

declare -A FILES=(
  ["arrow-right.svg"]="50357272-5cdf-404a-a527-4dcc5b8991c9"
  ["sc-rect-1.png"]="05de9b69-827e-46fd-bb03-f42257d59cbe"
  ["sc-rect-2.png"]="1cb0a7be-aef2-454e-8838-6c771704a824"
  ["manufacturing-bg.png"]="b15aeab3-d5ab-4fbe-ac00-d3d86fe4fe51"
  ["retail-bg.png"]="3f8e2785-259f-429a-b15e-2605310868fd"
  ["distribution-bg.png"]="4fdd6195-24b9-4969-96e2-267e5a23ef51"
  ["hero-bg.png"]="3d9bad0f-239d-4333-a969-3b2e6d1c5043"
  ["footer-deco-1.svg"]="39578433-030d-4622-8496-a469aa742058"
  ["footer-deco-2.svg"]="15354026-e1b1-4709-99b3-fddac8f53478"
  ["footer-deco-3.svg"]="3e39d6d1-2223-4340-b8d0-a5423715d8d5"
  ["coti-logo-dark.png"]="f8f3113b-0f4d-426e-915c-78012e571597"
  ["chevron-down.svg"]="d141ad0e-0c2d-4080-bf20-84c485399b2d"
  ["arrow-tiny.svg"]="ad3eb125-a160-4cc1-abe4-1f8fe181ba69"
  ["nextgen-logo.png"]="9a50ed8f-c197-41b7-a198-259991e495d4"
  ["sc-labs-1.svg"]="561a764c-f4cb-4d3e-ac4d-517d67068b48"
  ["sc-labs-2.svg"]="7584f535-731e-418b-9c5a-d30011c0cfe6"
  ["ands-logo.svg"]="2c54d7f0-9c8c-4e35-9d42-24d335082fea"
  ["nextgen-large.png"]="fcca0ab9-9146-474b-88b5-bd404600dc86"
  ["sc-labs-1-large.svg"]="1a04a0e8-cb20-4b40-ab9c-0bde505405cf"
  ["sc-labs-2-large.svg"]="75bdc3cd-ea82-452f-9da4-577b06a4192f"
  ["ands-logo-large.svg"]="bfdf8e9f-0cb3-464e-885e-bec446bbcffd"
  ["coti-logo.png"]="9808824a-7938-4a98-ba4e-36b4b5e70899"

  # Capabilities page (1:205) — additional assets
  ["timeline-node.png"]="d06d568c-fab9-4aa9-978b-aad825a2bcb1"
  ["cap-hero-line.svg"]="5b721cac-5ee5-4bb4-add2-2962aa31b12b"
  ["cap-build.png"]="02220457-9783-42a0-9e4d-f8beb9665b7b"
  ["cap-integrate.png"]="d0b243ae-2768-4e7e-a793-5601bd94185d"
  ["cap-scale.png"]="d8914cd0-46ad-46de-9a1f-73cb7802b113"
)

echo "Downloading ${#FILES[@]} Figma assets..."
for name in "${!FILES[@]}"; do
  uuid="${FILES[$name]}"
  printf "  -> %-30s " "$name"
  if curl -fsSL --max-time 30 "$BASE/$uuid" -o "$name"; then
    echo "ok"
  else
    echo "FAILED"
  fi
done

echo ""
echo "Done. Assets are in $(pwd)"
