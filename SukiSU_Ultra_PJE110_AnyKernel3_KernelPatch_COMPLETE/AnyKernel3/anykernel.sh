# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers
# Adapted for SukiSU Ultra + KernelPatch
# Target: OnePlus Ace 3 / OnePlus 12R (PJE110/aston)
# Android: 16 | Kernel: 5.15.180-android13-8 | Snapdragon 8 Gen 2

### AnyKernel setup
properties() { '
kernel.string=SukiSU Ultra | KernelPatch | PJE110/aston | Android 16 | 5.15.180 | SD 8 Gen 2
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=PJE110
device.name2=aston
device.name3=CPH2585
device.name4=CPH2609
device.name5=
supported.versions=16
supported.patchlevels=2026-04-
'; }

# shell variables
block=auto
is_slot_device=1
ramdisk_compression=auto
patch_vbmeta_flag=auto

## import functions/variables and setup
. tools/ak3-core.sh

## AnyKernel methods (DO NOT CHANGE)
dump_boot

## KernelPatch / SukiSU Ultra patching
ui_print "-----------------------------------"
ui_print " SukiSU Ultra + KernelPatch Patcher"
ui_print "-----------------------------------"
ui_print " Device  : OnePlus Ace 3 / 12R (PJE110)"
ui_print " Codename: aston"
ui_print " Kernel  : 5.15.180-android13-8"
ui_print " Android : 16"
ui_print " SoC     : Qualcomm Snapdragon 8 Gen 2"
ui_print "-----------------------------------"

# Apply KernelPatch to kernel image
if [ -f "$AKHOME/tools/kptools" ] && [ -f "$AKHOME/patch/kpimg" ]; then
  ui_print "- Found kptools + kpimg, applying KernelPatch..."

  KERNEL_IMG=""
  if [ -f "$AKHOME/split_img/boot.img-kernel" ]; then
    KERNEL_IMG="$AKHOME/split_img/boot.img-kernel"
  fi

  if [ -n "$KERNEL_IMG" ]; then
    chmod +x "$AKHOME/tools/kptools"

    # Backup original
    cp -f "$KERNEL_IMG" "${KERNEL_IMG}.bak"

    # Apply KernelPatch
    # kptools -p <kernel> --kpimg <kpimg> --skey <superkey> -o <output>
    "$AKHOME/tools/kptools" \
      -p "$KERNEL_IMG" \
      --kpimg "$AKHOME/patch/kpimg" \
      --skey "SukiSU_PJE110_Key" \
      -o "$KERNEL_IMG"

    if [ $? -eq 0 ]; then
      ui_print "  [OK] KernelPatch applied successfully!"
      ui_print "  SuperKey: SukiSU_PJE110_Key"
      ui_print "  (Change key in SukiSU Ultra Manager after boot)"
    else
      ui_print "  [WARN] KernelPatch failed, restoring original"
      ui_print "  Root will work in LKM mode"
      cp -f "${KERNEL_IMG}.bak" "$KERNEL_IMG"
    fi
    rm -f "${KERNEL_IMG}.bak"
  else
    ui_print "  [WARN] Kernel image not found in split_img"
  fi
else
  ui_print "- kptools or kpimg not found"
  ui_print "  KernelPatch skipped (LKM mode only)"
fi

ui_print "- Writing boot image..."

## Write boot image
write_boot

ui_print "-----------------------------------"
ui_print " Done! Open SukiSU Ultra Manager"
ui_print " and change your SuperKey!"
ui_print "-----------------------------------"

## end
