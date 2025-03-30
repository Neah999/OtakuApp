"use client";

import Link from "next/link";
import { FaList, FaTh, FaPlus } from "react-icons/fa";
import { useState, useEffect } from "react";
import ItemCard from "@/components/ItemCard";
import { iconMap } from "@/data/iconMap";
import { Item } from "./page";

export type Item = {
  name: string;
  count: number;
  imageUrl: string;
  icon: string;
  acquisitionDate?: string;
  explain?: string;
  prise?: number;
};

export default function HomePage() {
  const [items, setItems] = useState<Item[]>([]);
  const [isListView, setIsListView] = useState(false);
  
  useEffect(() => {
    const fetchData = async () => {
      const baseUrl = process.env.NEXT_PUBLIC_BASE_URL || "http://localhost:3000";
      const res = await fetch(`${baseUrl}/items.json`);
      const data: Item[] = await res.json();
      const mapped = data.map((item) => ({
        ...item,
        icon: iconMap[item.icon],
        count: Number(item.count),
      }));
      setItems(mapped);
    };
    fetchData();
  }, []);

  return (
    <main className="p-4 bg-white min-h-screen relative">
      {/* タイトル + リスト表示切り替え */}
      <div className="flex justify-between items-center mb-4">
        <h1 className="text-xl font-bold text-gray-800">ヲタクアイテム一覧</h1>
        <button
          onClick={() => setIsListView(!isListView)}
          className="text-gray-600 hover:text-black text-lg"
          title={isListView ? "カード表示" : "リスト表示"}
        >
          {isListView ? <FaTh /> : <FaList />}
        </button>
      </div>

      {/* 表示切り替え */}
      {isListView ? (
        <ul className="space-y-2">
          {items.map((item, i) => (
            <li key={i} className="flex items-center gap-3 border-b py-2">
              {/* リスト形式 */}
              <Link
                href={`/edit/${i}`}
                className="flex items-center gap-3 hover:bg-gray-50 p-2 rounded w-full"
              >
                <img
                  src={item.imageUrl}
                  alt={item.name}
                  className="w-12 h-12 rounded-full object-cover"
                />
                <div className="flex-1">
                  <div className="flex items-baseline gap-1">
                    <span className="text-sm font-bold text-black">{item.name}</span>
                    <span className="text-xs text-gray-700">× {item.count}</span>
                  </div>
                  <div className="text-xs text-gray-600">{item.explain}</div>
                  <div className="text-xs text-gray-500">
                    取得日: {item.acquisitionDate || "不明"} / ¥{item.prise?.toLocaleString() || "-"}
                  </div>
                </div>
              </Link>
            </li>
          ))}
        </ul>
      ) : (
        <div className="grid gap-4 grid-cols-[repeat(auto-fit,minmax(96px,1fr))]">
          {items.map((item, i) => (
            <Link key={i} href={`/edit/${i}`} className="flex flex-col items-center">
              <ItemCard {...item} />
            </Link>
          ))}
        </div>
      )}

      {/* + ボタン（右下に固定） */}
      <Link
        href="/new"
        title="新規追加"
        className="fixed bottom-8 right-8 z-50 bg-blue-500 text-white w-12 h-12 rounded-full flex items-center justify-center hover:bg-blue-600 shadow-lg"
      >
        <FaPlus size={20} />
      </Link>
    </main>
  );
}