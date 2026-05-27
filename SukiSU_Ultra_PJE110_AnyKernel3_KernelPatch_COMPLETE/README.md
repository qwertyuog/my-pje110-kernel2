# SukiSU Ultra AnyKernel3 — 一加 Ace 3 / OnePlus 12R (PJE110)

## 设备信息
| 项目 | 信息 |
|------|------|
| 设备型号 | 一加 Ace 3 / OnePlus 12R |
| 型号代码 | PJE110 |
| 设备代号 | aston |
| 处理器 | Qualcomm Snapdragon 8 Gen 2 (SM8550) |
| Android 版本 | 16 |
| 内核版本 | 5.15.180-android13-8-o-01178-ge9806715b271 |
| 安全补丁 | 2026年4月1日 |
| 全球型号 | CPH2585 (印度) / CPH2609 (国际) |

> **重要：** PJE110 是**高通 SM8550 设备**，社区支持远比 MTK 设备完善。
> WildKernels、XDA 上均有成熟的 SukiSU / KernelSU 内核资源。

---

## ⚡ 方式一：GitHub Actions 自动编译（推荐）

### 步骤：
1. 登录 GitHub，新建仓库（如 `my-pje110-kernel`）
2. 上传本包：
   - 将 `GithubActions/build_kernel.yml` → 放到 `.github/workflows/build_kernel.yml`
   - 将 `AnyKernel3/` 目录整体上传
3. 进入仓库 → **Actions** → `Build SukiSU Ultra Kernel - PJE110`
4. 点击 **Run workflow**，填写参数：
   - SuperKey：设置你自己的密钥（不要用默认值！）
   - SukiSU 分支：推荐 `susfs-dev`
   - 启用 KPM：`true`
   - 启用 SUSFS：`true`
5. 等待约 **30-60 分钟** 编译完成
6. 在 Releases 页面下载 ZIP 直接刷入

---

## ⚡ 方式二：社区已有预编译内核

由于 PJE110 是高通设备，社区已有成熟预编译资源，可直接下载使用：

| 来源 | 地址 |
|------|------|
| WildKernels (SukiSU+SUSFS) | https://github.com/WildKernels/OnePlus_KernelSU_SUSFS/releases |
| XDA 指南（OnePlus 12R / Ace 3） | https://xdaforums.com/t/guide-to-oneplus-13r-ace-5-kernelsu-next-sukiultra-twrp-rooting-and-goodies.4716428/ |

在上述 Releases 中找包含 `aston` 或 `12r` 或 `Ace3` + `SukiSU` 关键词的文件即可。

---

## 📦 包内文件说明

```
├── AnyKernel3/
│   ├── anykernel.sh              # 已配置 PJE110 / aston 的安装脚本
│   └── META-INF/                 # Recovery 安装器
├── GithubActions/
│   └── build_kernel.yml          # GitHub Actions 编译工作流
└── README.md                     # 本文档
```

---

## 🔧 KernelPatch 说明

`anykernel.sh` 包含完整 KernelPatch 逻辑：
- 安装时自动检测 `kptools` 和 `kpimg`
- 对内核镜像打 KernelPatch，启用 KPM 模块支持
- 若工具不存在则退回 LKM 模式

---

## ⚠️ 注意事项

1. **刷机前必须**：已解锁 Bootloader + 安装第三方 Recovery
2. **备份 boot 分区**：
   ```bash
   adb shell su -c "dd if=/dev/block/by-name/boot of=/sdcard/boot_bak.img"
   ```
3. **首次刷入后立即修改 SuperKey**（在 SukiSU Ultra Manager 中操作）
4. PJE110 升级到 Android 16 后如遇问题，参考：
   https://github.com/inferno0230/op12r-fw-repo

---

## 🔗 相关资源

| 资源 | 地址 |
|------|------|
| SukiSU Ultra Manager | https://github.com/SukiSU-Ultra/SukiSU-Ultra/releases |
| KernelPatch 工具 | https://github.com/SukiSU-Ultra/SukiSU_KernelPatch_patch |
| SUSFS 模块 | https://github.com/sidex15/susfs4ksu-module |
| OrangeFox (aston) | https://orangefox.download/device/aston |
| OnePlus SM8550 内核源码 | https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550 |
| AnyKernel3 (KSU 版) | https://github.com/Kernel-SU/AnyKernel3 |
