"use client";

import { useEffect, useState } from "react";
import { useParams, useRouter } from "next/navigation";
import { Item } from "@/app/page";
import { iconMap } from "@/data/iconMap";

type Props = {
  mode: "new" | "edit";
};

export default function ItemForm({ mode }: Props) {
  const params = useParams();
  const id = params?.id as string;
  const router = useRouter();

  const [item, setItem] = useState<Item | null>(null);
  const [imagePreview, setImagePreview] = useState<string | null>(null);
  const [selectedFileName, setSelectedFileName] = useState<string>("");
  const [selectedFile, setSelectedFile] = useState<File | null>(null);

  useEffect(() => {
    if (mode === "edit" && id) {
      (async () => {
        const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || "http://localhost:3000";
        const res = await fetch(`${baseUrl}/items.json`);
        const data: Item[] = await res.json();
        const target = data[Number(id)];
        if (target) {
          setItem(target);
          setImagePreview(target.imageUrl);
        }
      })();
    } else {
      // 新規作成の初期値
      setItem({
        name: "",
        count: 0,
        imageUrl: "",
        icon: "FaCircle",
        prise: 0,
        explain: "",
        acquisitionDate: "",
      });
    }
  }, [mode, id]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    if (!item) return;
    const { name, value } = e.target;
    setItem({
      ...item,
      [name]: name === "count" || name === "prise" ? Number(value) : value,
    });
  };

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    setSelectedFile(file);
    setSelectedFileName(file.name);
    const reader = new FileReader();
    reader.onloadend = () => {
      setImagePreview(reader.result as string);
    };
    reader.readAsDataURL(file);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
  
    if (!item?.name.trim()) {
      alert("名前は必須です！");
      return;
    }
  
    // FormData を作成
    const formData = new FormData();
    formData.append("item", JSON.stringify(item));
    if (selectedFile) {
      formData.append("image", selectedFile);
    }
  
    const response = await fetch("/api/save", {
      method: "POST",
      // Content-Type ヘッダーは自動的に設定されるので削除
      body: formData,
    });
  
    if (response.ok) {
      alert("保存しました！");
      router.push("/");
    } else {
      alert("保存に失敗しました");
    }
  };

  if (!item) return <div>読み込み中...</div>;

  return (
    <main className="p-4 max-w-xl mx-auto bg-white text-black">
      <h1 className="text-xl font-bold mb-4">{mode === "edit" ? "アイテム編集" : "新規作成"}</h1>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-sm">名前</label>
          <input
            type="text"
            name="name"
            value={item.name}
            onChange={handleChange}
            required
            className="w-full border border-gray-300 rounded p-2 bg-blue-50"
          />
        </div>

        <div>
          <label className="block text-sm">個数</label>
          <input
            type="text"
            name="count"
            inputMode="numeric"
            value={item.count}
            onChange={handleChange}
            className="w-full border border-gray-300 rounded p-2 bg-blue-50"
          />
        </div>

        <div>
          <label className="block text-sm">価格</label>
          <input
            type="text"
            name="prise"
            inputMode="numeric"
            value={item.prise?.toLocaleString() || ""}
            onChange={(e) => {
              const numeric = Number(e.target.value.replace(/,/g, ""));
              setItem({ ...item, prise: numeric });
            }}
            className="w-full border border-gray-300 rounded p-2 bg-blue-50"
          />
        </div>

        <div>
          <label className="block text-sm">説明</label>
          <textarea
            name="explain"
            value={item.explain || ""}
            onChange={handleChange}
            className="w-full border border-gray-300 rounded p-2 bg-blue-50"
          />
        </div>

        <div>
          <label className="block text-sm">取得日</label>
          <input
            type="date"
            name="acquisitionDate"
            value={item.acquisitionDate || ""}
            onChange={handleChange}
            className="w-full border border-gray-300 rounded p-2 bg-blue-50"
          />
        </div>

        <div>
          <label className="block text-sm font-medium mb-1">画像</label>
          <div className="flex items-center gap-4">
            {imagePreview && (
              <img
                src={imagePreview}
                alt="preview"
                className="w-28 h-28 object-cover rounded-full border border-gray-300"
              />
            )}
            <div className="flex flex-col gap-2">
              <label
                htmlFor="imageUpload"
                className="cursor-pointer inline-block px-4 py-2 text-sm text-white bg-blue-500 rounded hover:bg-blue-600"
              >
                ファイルを選択
              </label>
              <input
                id="imageUpload"
                type="file"
                accept="image/*"
                onChange={handleImageChange}
                className="hidden"
              />
              {selectedFileName && (
                <div className="px-2 py-1 border border-gray-300 bg-gray-100 rounded text-xs text-gray-600">
                  {selectedFileName}
                </div>
              )}
            </div>
          </div>
        </div>
        <div className="flex gap-2">
          <button
            type="button"
            onClick={() => router.back()}
            className="absolute top-4 right-4 z-50 bg-gray-300 text-black px-3 py-1 rounded hover:bg-gray-400"
          >
            戻る
          </button>
          <button
            type="submit"
            className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded"
          >
            保存
          </button>
        </div>
      </form>
    </main>
  );
}
