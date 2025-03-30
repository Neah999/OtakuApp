// src/app/api/save/route.ts
import { NextRequest, NextResponse } from "next/server";
import fs from "fs/promises";
import path from "path";

export const config = {
  runtime: "nodejs",
};

export async function POST(req: NextRequest) {
  try {
    // NextRequest の組み込み formData() を利用
    const formData = await req.formData();
    // "item" フィールドに JSON 文字列が入っている前提
    const itemJson = formData.get("item") as string;
    const itemData = JSON.parse(itemJson);

    // "image" フィールドがある場合、File オブジェクトとして取得
    const file = formData.get("image") as File | null;
    if (file) {
      const itemsDir = path.join(process.cwd(), "public", "items");
      await fs.mkdir(itemsDir, { recursive: true });

      // ファイル名を取得（重複回避のため後でリネーム処理）
      let fileName = file.name || "upload.png";
      let targetPath = path.join(itemsDir, fileName);
      let counter = 1;
      while (true) {
        try {
          await fs.access(targetPath);
          const ext = path.extname(fileName);
          const base = path.basename(fileName, ext);
          fileName = `${base} (${counter})${ext}`;
          targetPath = path.join(itemsDir, fileName);
          counter++;
        } catch (err) {
          break;
        }
      }
      // File オブジェクトから ArrayBuffer を取得して Buffer に変換
      const buffer = Buffer.from(await file.arrayBuffer());
      await fs.writeFile(targetPath, buffer);
      // 保存した画像パスを itemData に設定
      itemData.imageUrl = `/items/${fileName}`;
    }

    // items.json の更新処理
    const itemsJsonPath = path.join(process.cwd(), "public", "items.json");
    const raw = await fs.readFile(itemsJsonPath, "utf-8");
    const items = JSON.parse(raw);
    const index = items.findIndex((i: any) => i.name === itemData.name);
    if (index !== -1) {
      items[index] = itemData;
    } else {
      items.push(itemData);
    }
    await fs.writeFile(itemsJsonPath, JSON.stringify(items, null, 2), "utf-8");

    return NextResponse.json({ success: true, item: itemData });
  } catch (error) {
    console.error("保存処理エラー:", error);
    return NextResponse.error();
  }
}
